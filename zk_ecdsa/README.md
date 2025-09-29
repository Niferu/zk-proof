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
