package main

import (
	"fmt"

	"github.com/blevesearch/bleve" // A full-text search and indexing library
	"github.com/google/osv-scanner/pkg/models"
	vaulthttp "github.com/hashicorp/vault/http"
	"github.com/hashicorp/vault/vault"
)

func main() {
	// Vulnerable code:
	core := vault.TestCoreWithConfig(nil, &vault.CoreConfig{})
	vaulthttp.TestServer(nil, core)

	// Non-vulnerable code: Just a simple print statement
	fmt.Printf("Hello, Vulnerable World %d!", models.EcosystemGo)
	indexMapping := bleve.NewIndexMapping()
	indexMapping.DefaultMapping.AddFieldMappingsAt("example_field", bleve.NewTextFieldMapping())
}
