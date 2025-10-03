# Simple Circuit

### How to use

```bash
# Checks if code, packages etc. are correct + creates 'Prover.toml'
nargo check

# Once we fill 'Prover.toml' it will compile circuit into ACIR and execute compiled circuit and then compute witness
nargo execute

# Creates proof (-b - bytecode; -w - witness; -o - output)
bb prove -b ./target/simple_circuit.json -w ./target/simple_circuit.gz -o ./target

# Generates verification key
bb write_vk -b ./target/simple_circuit.json -o ./target

# Verifies proof (-k - verification key; -p - proof)
bb verify -k ./target/vk -p ./target/proof
```

If we change anything, remove 'target' folder and start again
