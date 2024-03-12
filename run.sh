ecosystem=$1
buildImage=$2
json=$3

if [[ $1 == "-h" || $1 == "--help" || $# -lt 3 ]]; then  # Check for help flags or insufficient arguments
    echo "Usage: run.sh ecosystem buildImage json"
    echo "Where:"
    echo "  ecosystem:  The name of the ecosystem: go, cargo, maven, npm or debian"
    echo "  buildImage: 'true' to indicate image build"
    echo "  json:       'true' to output the results in JSON format"
    exit 0 
fi

if [ -z "$ecosystem" ]; then
  echo "Please specify an ecosystem."
  exit 0
fi

docker="$ecosystem-tester"
if [[ "$buildImage" == "true" ]]; then
  echo "building docker image from ./docker/$ecosystem/"
  docker image rm $docker
  rm -rf ./docker/$ecosystem/$docker.tar
  docker build -t $docker ./docker/$ecosystem/
  docker save $docker -o ./docker/$ecosystem/$docker.tar
fi

if [[ "$json" == "true" ]]; then
  echo "Generating JSON results."
  ~/go/bin/osv-scanner scan --experimental-oci-image ./docker/$ecosystem/$docker.tar --json --output ./result/$ecosystem/osv_scanner.json --call-analysis=all
  trivy image --format json --scanners vuln $docker > ./result/$ecosystem/trivy.json
  grype $docker --scope all-layers -o json > ./result/$ecosystem/grype.json
  SNYK_TOKEN=$token snyk container test --json $docker > ./result/$ecosystem/snyk.json
  docker scout cves --format sarif --details $docker > ./result/$ecosystem/docker_scout.json
  exit 0
fi

echo "Running osv-scanner for source folder"
~/go/bin/osv-scanner scan --experimental-oci-image ./docker/$ecosystem/$docker.tar --output ./result/$ecosystem/osv_scanner.txt --call-analysis=all

echo "$(date +"%Y-%m-%d %T") Running trivy"
trivy image --scanners vuln $docker > ./result/$ecosystem/trivy.txt

echo "$(date +"%Y-%m-%d %T") Running grype"
grype $docker > ./result/$ecosystem/grype.txt

echo "$(date +"%Y-%m-%d %T") Running snyk"
SNYK_TOKEN=$token snyk container test $docker > ./result/$ecosystem/snyk.txt

echo "$(date +"%Y-%m-%d %T") Running docker scout"
docker scout cves $docker > ./result/$ecosystem/docker_scout.txt

echo "$(date +"%Y-%m-%d %T") Finished"