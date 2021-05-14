# Vow Doc Helper

Vow Doc Helper allows to easily create a Vow Doc.

## Provide Operations

1. Creates a `VowDoc` from the given `wallet`, the list of recipients `recipients`, an unique document `id` (UUID v4 format) and document `metadata`. Optionally `contentUri`, `checksum`, `doSign`, `encryptedData`, `aesKey` can be provided. If `doSign` is provided then also the `checksum` field is required.

   ```dart
   static Future<VowDoc> fromWallet({
      required Wallet wallet,
      required List<String> recipients,
      required String id,
      required VowDocMetadata metadata,
      String? contentUri,
      VowDocChecksum? checksum,
      VowDoSign? doSign,
      Set<VowEncryptedData>? encryptedData,
      Uint8List? aesKey,
      http.Client? client,
   })
   ```

## Usage examples

```dart
// Configure the blockchain network
final networkInfo = NetworkInfo(
  bech32Hrp: 'did:vow:',
  lcdUrl: 'http://localhost:1317',
);

// Derive the sender wallet from her mnemonics
final senderMnemonic = ['will', 'hard', ..., 'man'];
final senderWallet = Wallet.derive(senderMnemonic, networkInfo);

// Get the recipient(s) wallet address
final docRecipientDid = 'did:vow:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau';

// Generate a random UUID (or use a meaningful one)
final docId = Uuid().v4();

// URI location of the shared document
final contentUri = 'https://example.com/document.pdf';

// Let's assume that we want to encrypt the CONTENT_URI field to hide the document location in the resulting transaction
final encryptedData = { VowEncryptedData.CONTENT_URI };

// Let's assume that we have computed the document checksum in SHA256
final checksum = VowDocChecksum(
  value: 'a00ab326fc8a3dd93ec84f7e7773ac2499b381c4833e53110107f21c3b90509c',
  algorithm: VowDocChecksumAlgorithm.SHA256,
);

// Let's assume that we want to digitally sign
final doSign = VowDoSign(
  storageUri: 'http://vowchain.net',
  signerIstance: 'did:vow:1cc65t29yuwuc32ep2h9uqhnwrregfq230lf2rj',
  sdnData: {
    VowSdnData.COMMON_NAME,
    VowSdnData.SURNAME,
  },
  vcrId: 'xxxxx',
  certificateProfile: 'xxxxx',
);

try {
  final VowDoc = await VowDocHelper.fromWallet(
    wallet: senderWallet,
    recipients: [docRecipientDid],
    id: docId,
    metadata: VowDocMetadata(
      contentUri: 'https://example.com/document/metadata',
      schema: VowDocMetadataSchema(
        uri: 'https://example.com/custom/metadata/schema',
        version: '7.0.0',
      ),
    ),
    contentUri: contentUri,
    checksum: checksum,
    doSign: doSign,
    encryptedData: encryptedData,
  );

  // Send the derived VowDoc to the blockchain
  final txResult = await DocsHelper.shareDocumentsList(
    [VowDoc],
    senderWallet,
  );
} catch (error) {
  // Handle error
}
```
