use dep::ecrecover;

fn is_less_than_or_equal(a: [u8; 32], b: [u8; 32]) -> bool {
    let mut result = true;
    let mut found_difference = false;

    for i in 0..32 {
        if !found_difference {
            if a[i] < b[i] {
                result = true;
                found_difference = true;
            } else if a[i] > b[i] {
                result = false;
                found_difference = true;
            }
        }
    }

    result
}

fn main(
    pub_key_x: [u8; 32],
    pub_key_y: [u8; 32],
    signature: [u8; 64],
    hashed_message: pub [u8; 32],
    expected_address: Field,
) {
    let address = ecrecover::ecrecover(pub_key_x, pub_key_y, signature, hashed_message);

    // Use below for 'nargo versions > 1.0.0-beta.3'
    // let isValid = ecdsa_secp256k1::verify_signature(pub_key_x, pub_key_y, signature, hashed_message);
    // assert(isValid);

    std::println(f"Address: {address}");
    std::println(f"Expected address: {expected_address}");
    assert(address == expected_address, "Address does not match expected address");
    assert(
        address != 0x0000000000000000000000000000000000000000,
        "Invalid signature: zero address",
    );

    // Malleability check - ensure s value is in lower half of curve order

    // Extract s from signature (last 32 bytes)
    let mut s_bytes: [u8; 32] = [0; 32];
    for i in 0..32 {
        s_bytes[i] = signature[i + 32];
    }

    // Half of secp256k1 curve order as bytes
    // n = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141 (n < 2^256; n = 2^256 - 128-bit constant)
    // n/2 = 0x7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5D576E7357A4501DDFE92F46681B20A0
    let half_curve_order: [u8; 32] = [
        0x7F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
        0xFF, 0x5D, 0x57, 0x6E, 0x73, 0x57, 0xA4, 0x50, 0x1D, 0xDF, 0xE9, 0x2F, 0x46, 0x68, 0x1B,
        0x20, 0xA0,
    ];
    assert(
        is_less_than_or_equal(s_bytes, half_curve_order),
        "Invalid signature: s value too high (malleable)",
    );
}

#[test]
fn test_main() {
    // Mock test data - replace with real signature data for actual testing
    // These values are placeholders and will fail verification
    let _pub_key_x: [u8; 32] = [0; 32];
    let _pub_key_y: [u8; 32] = [0; 32];
    let _signature: [u8; 64] = [0; 64];
    let _hashed_message: [u8; 32] = [0; 32];
    let _expected_address: Field = 0x0000000000000000000000000000000000000000;

    // Uncomment to run test with mock data (will fail)
    // main(
    //     _pub_key_x,
    //     _pub_key_y,
    //     _signature,
    //     _hashed_message,
    //     _expected_address,
    // );
}
