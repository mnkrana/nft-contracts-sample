## Steps to get started

### Setup project

- yarn init
- yarn add -D hardhat
- yarn hardhat init
- yarn hardhat compile

### IPFS

- add images
- generate metadata
- upload them to IPFS

Images Uri

```
QmWQdK2rhBFn3i2TwWCuzTsx2au4mvoF8TKBT5seo3K73p
```

Metadata Uri

```
Qmb269DT2JWVq6AyibidEkDQ99CwMHsZTvwYy3AEBrfa11
```

NFT contract metadata Uri

```
QmXdHFZYPMf6AizqVmJrXPgNfyfYtr2oErpDy9JKywX21E
```

To download/verify these files:

```
ipfs get <uri>
```

### ERC-1155

- create a NFT contract
- add deploy script
- add verify script
- add dependencies

Dependencies:

- yarn add -D @nomicfoundation/hardhat-verify
- yarn add -D hardhat-deploy
- yarn add -D dotenv
- yarn add -D @solarity/hardhat-gobind

### Deploy

- update hardhat.config.js to add the network chain configuration
- use a .env file to store private keys

Deploy and verify

```
yarn hardhat deploy --network puppy
```

### Puppynet

- Contract Address : 0xDB929853F31f9cfccF753A2Cec27c6A37c9D8bFa
- https://puppyscan.shib.io/address/0xDB929853F31f9cfccF753A2Cec27c6A37c9D8bFa
- Check all minted tokens here
- https://puppyscan.shib.io/token/0xDB929853F31f9cfccF753A2Cec27c6A37c9D8bFa
