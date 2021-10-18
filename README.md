# Compile projects

## Generate SE and Verilator library

```bash
make
```

## Make tiny crypt

```bash
pushd functional-library/src/ciphers/aes/tinyCrypt_without_Git
make
popd
pushd functional-library/src/rng/mersenne-twister-1
make
popd
```

## Compile abd run test casts

```bash
cd functional-library/src/verilator
make
./test
```
