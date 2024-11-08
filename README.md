# Token Bounded Account - ERC6551 - Minimal Walkthrough

This project is a minimal walkthrough of the ERC6551 standard. The ERC6551 standard is a token bounded account standard that allows for the creation of a token that is bound to an account. This means that the token can only be transferred to the account that it is bound to.

# Getting Started

## Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`

## Quickstart

```
git clone https://github.com/cqlyj/tba-erc6551
cd tba-erc6551
make
```

## Testing

Run:

```
forge test
```

# Usage - Walkthrough the ERC6551 standard

1. Set up your environment variables:

```bash
cp .env.example .env
```

If you just want to run this in local anvil chain, the .env.example already have those pre-configured. You can just delete other env variables.

2. Spin up a local anvil chain:

```bash
make anvil
```

3. Spin up a new terminal and run:

```bash
make walk-through
```
