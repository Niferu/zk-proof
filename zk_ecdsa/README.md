# ZK ECDSA

## Nargo Version

Works only with specific `nargo` version:

```bash
1.0.0-beta.3

# Use specific version of noir
noirup -v 1.0.0-beta.3

# Update Barretenberg to compatible version
bbup
```

## Create hashed message

```bash
cast keccak <"message">
```

## Create expected address

```bash
cast wallet address --account <account>
```

## Get public key

```bash
# Use 'foundryup' if 'public-key' command does not exist
cast wallet public-key --account <account>

# Ask AI to split it into x and y (32 bytes each = 64 hex chars without 0x) save x and y with 0x at the beginning
```

## Get signature

```bash
cast wallet sign --no-hash <hashed-message> --account <account>
```

## Execute bash script

```bash
# chmod: 'change mod', +x: 'add execute permission'
chmod +x generate-inputs.sh

# Execute script
./generate-inputs.sh

# Close 'Prover.toml' if needed
```

## Run locally

```bash
nargo execute
bb prove <with-proper-params>
bb write_vk <with-proper-params>
bb verify <with-proper-params>
```

## Create verifying smart conract

```bash
# Remove '/target, Prover.toml, inputs.txt and generate-inputs.sh'
nargo compile
```
