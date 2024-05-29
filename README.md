# Foundry-NFT

In this project we will be building an NFT contract on we will deploy on anvil chain and interact with it. 
Also we will be defining functions like:

* Mint Function: This Function will Mint our NFT Token
* Transfer Function: Allows to Trandfer NFT to different users
* Burn Function: Allows to permanently delete/BURN the Token 

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
