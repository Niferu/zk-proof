// Default params are private (only known to a prover), if 'pub' (known to prover and verifier)
// Field type is similar to integer
fn main(x: Field, y: pub Field) {
    assert(x != y);
}

#[test]
fn test_main() {
    main(1, 2);
}

#[test(should_fail)]
fn test_main_should_fail() {
    main(1, 1);
}
