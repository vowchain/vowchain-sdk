# Glossary

Here are collected all that common terms that you should know while you are working with Vow Chain

## Did

Directly from [Did Specifications](https://w3c.github.io/did-core/):
> A DID is a simple text string that consists of three parts:
>
> 1) the URL scheme identifier (did);
> 2) the identifier for the DID method;
> 3) the DID method-specific identifier.

:::tip Example of Vow Chain Did
did:vow:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc
:::

This Did in simple words it's nothing but a link that resolves to a specific Did Document.

### Did in SDK

Inside the SDK the did is a simple `String` like the one above.

## Did Document

Directly from [Did Specifications](https://w3c.github.io/did-core/):
> A Did Document contains information associated with the Did such as ways to cryptographically authenticate the entity in control of the Did, as well as services that can be used to interact with the entity.

:::tip Did Document Example (specific for Vow Chain)

  ```json
  {
    "@context":"https://www.w3.org/ns/did/v1",
    "id":"did:vow:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc",
    "publicKey":[
        {
          "id":"did:vow:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc#keys-1",
          "type":"RsaVerificationKey2018",
          "controller":"did:vow:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc",
          "publicKeyPem":"-----BEGIN PUBLIC KEY----MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMr3V+Auyc+zvt2qX+jpwk3wM+m2DbfLjimByzQDIfrzSHMTQ8erL0kg69YsXHYXVX9mIZKRzk6VNwOBOQJSsIDf2jGbuEgI8EB4c3q1XykakCTvO3Ku3PJgZ9PO4qRw7QVvTkCbc91rT93/pD3/Ar8wqd4pNXtgbfbwJGviZ6kQIDAQAB-----END PUBLIC KEY-----\r\n"
        },
        {
          "id":"did:vow:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc#keys-2",
          "type":"RsaSignature2018",
          "controller":"did:vow:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc",
          "publicKeyPem":"-----BEGIN PUBLIC KEY----MIGfM3TvO3Ku3PJgZ9PO4qRw7+Auyc+zvt2qX+jpwk3wM+m2DbfLjimByzQDIfrzSHMTQ8erL0kg69YsXHYXVX9mIZKRzk6VNwOBOQJSsIDf2jGbuEgI8EB4c3q1XykakCQVvTkCbc9A0GCSqGSIbqd4pNXtgbfbwJGviZ6kQIDAQAB-----END PUBLIC KEY-----\r\n"
        }
    ],
    "proof":{
        "type":"EcdsaSecp256k1VerificationKey2019",
        "created":"2019-02-08T16:02:20Z",
        "proofPurpose":"authentication",
        "controller":"did:vow:14zk9u8894eg7fhgw0dsesnqzmlrx85ga9rvnjc",
        "verificationMethod":"<did bech32 pubkey>",
        "signatureValue":"QNB13Y7Q91tzjn4w=="
    }
  }
  ```

:::

### DidDocument in SDK

Inside the SDK it is an object of type `DidDocument`:  

  ```dart
  class DidDocument extends Equatable {
    @JsonKey(name: '@context')
    final String context;

    @JsonKey(name: 'id')
    final String id;

    @JsonKey(name: 'publicKey')
    final List<DidDocumentPublicKey> publicKeys;

    @JsonKey(name: 'proof')
    final DidDocumentProof proof;

    @JsonKey(name: 'service', includeIfNull: false)
    final List<DidDocumentService> service;

    DidDocument({
      @required this.context,
      @required this.id,
      @required this.publicKeys,
      @required this.proof,
      this.service,
    });
  }
  ```

## Did Power Up Request

Directly from [Vow Chain Documentation](https://docs.vowchain.net/x/id/#requesting-a-did-power-up):
> A Did Power Up is the expression we use when referring to the willingness of a user to move a specified amount of tokens from external centralized entity to one of his private pairwise Did, making them able to send documents (which indeed require the user to spend some tokens as fees).

:::tip Did Power Up Request example

  ```json
  {
    "claimant":"address that sent funds to the centralized entity before",
    "amount":[
        {
          "denom":"uvow",
          "amount":"amount to transfer to the pairwise did, integer"
        }
    ],
    "proof":"proof string",
    "id":"randomly-generated UUID v4",
    "proof_key":"proof encryption key"
  }
  ```

:::

### MsgRequestDidPowerUp in SDK

Inside the SDK it is an object of type `MsgRequestDidPowerUp`

  ```dart
  class MsgRequestDidPowerUp extends StdMsg {
    final String claimantDid;
    final List<StdCoin> amount;
    final String powerUpProof;
    final String uuid;
    final String encryptionKey;

    MsgRequestDidPowerUp({
      @required this.claimantDid,
      @required this.amount,
      @required this.powerUpProof,
      @required this.uuid,
      @required this.encryptionKey,
    })
  ```
