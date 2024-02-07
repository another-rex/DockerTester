fn main() {
    println!("Hello, world!");
    use shlex::bytes::quote;
    let _a = quote(b"111");

    println!("Bytes");
}
