fn main(guess_hash: Field, answer_hash: pub Field) {
    assert(guess_hash == answer_hash, "Incorrect answer!");
}

#[test]
fn test_main() {
    main(1, 1);
}

#[test(should_fail)]
fn test_main_should_fail() {
    main(1, 3);
}
