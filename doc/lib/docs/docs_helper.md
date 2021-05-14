# Docs helper

Docs helper allows to easily perform all the operations related to the Vow Chain `docs` module.

## Provided operations

1. Creates a new transaction that allows to share the document associated with the given `metadata`, document `id`, `recipients` and with the sender `wallet`. Optional fields are `contentUri`, `doSign`, `checksum`, `fee` and the broadcasting `mode`.

   If `encryptedData` is specified, encrypts the proper data and optional `aesKey` for the specified `recipients` and then sends the transaction to the blockchain. If `doSign` is provided then also the `checksum` field is required.

    ```dart
    static Future<TransactionResult> shareDocument({
      required String id,
      required VowDocMetadata metadata,
      required List<String> recipients,
      required Wallet wallet,
      String? contentUri,
      VowDoSign? doSign,
      VowDocChecksum? checksum,
      Uint8List? aesKey,
      Set<VowEncryptedData>? encryptedData,
      StdFee? fee,
      BroadcastingMode? mode,
      http.Client? client,
    })
    ```

    Example:

    ```dart
    final txResult = await DocsHelper.shareDocument(
      wallet: wallet,
      id: Uuid().v4(),
      recipients: ['did:vow:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau'],
      metadata: VowDocMetadata(
        contentUri: 'https://example.com/document.pdf',
        schemaType: '-',
      ),
    );
    ```

2. Create a new transaction that allows to share a list of previously generated documents `VowDocsList` signing the transaction with `wallet`. Optionally `fee` and broadcasting `mode` parameters can be specified.

    ```dart
    static Future<List<VowDoc>> getSentDocuments({
      required String address,
      required NetworkInfo networkInfo,
      http.Client? client,
    })
    ```

    Example:

    ```dart
    final VowDoc = await VowDocHelper.fromWallet(
      wallet: wallet,
      id: Uuid().v4(),
      recipients: ['did:vow:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau'],
      metadata: VowDocMetadata(
        contentUri: 'https://example.com/document.pdf',
        schemaType: '-',
      ),
    );

    final txResult = await DocsHelper.shareDocumentsList([VowDoc], wallet);
    ```

3. Returns the list of all the `VowDoc` that the specified `address` has sent

    ```dart
    static Future<List<VowDoc>> getSentDocuments({
      required String address,
      required NetworkInfo networkInfo,
      http.Client? client,
    })
    ```

    Example:

    ```dart
    final documents = await DocsHelper.getSentDocuments(
      address: wallet.bech32Address,
      networkInfo: networkInfo,
    );
    ```

4. Returns the list of all the `VowDoc` that the specified `address` has received

    ```dart
    static Future<List<VowDoc>> getReceivedDocuments({
      required String address,
      required NetworkInfo networkInfo,
      http.Client? client,
    })
    ```

    Example:

    ```dart
    final documents = await DocsHelper.getSentDocuments({
      @required String address,
      @required NetworkInfo networkInfo,
      http.Client client,
    });
    ```

5. Creates a new transaction which tells the `recipient` that the document having the specified `documentId` and present inside the transaction with `txHash` has been properly seen; optionally `proof` of reading, `fee` and broadcasting `mode`.

    ```dart
    static Future<TransactionResult> sendDocumentReceipt({
      required String recipient,
      required String txHash,
      required String documentId,
      required Wallet wallet,
      String? proof,
      StdFee? fee,
      BroadcastingMode? mode,
      http.Client? client,
    })
    ```

6. Creates a new transaction which sends a list of previously generated receipts  `VowDocReceiptsList`. Optionally `fee` and broadcasting `mode` parameters can be specified.

   ```dart
   static Future<TransactionResult> sendDocumentReceiptsList(
      List<VowDocReceipt> VowDocReceiptsList,
      Wallet wallet, {
      StdFee? fee,
      BroadcastingMode? mode,
      http.Client? client,
   })
   ```

7. Returns the list of all the `VowDocReceipt` that have been sent from the given `address`

    ```dart
    static Future<List<VowDocReceipt>> getSentReceipts({
      required String address,
      required NetworkInfo networkInfo,
      http.Client? client,
    })
    ```

8. Returns the list of all the `VowDocRecepit` that have been received from the given `address`

    ```dart
    static Future<List<VowDocReceipt>> getReceivedReceipts({
      required String address,
      required NetworkInfo networkInfo,
      http.Client? client,
    })
    ```

## Usage examples

```dart
final info = NetworkInfo(
  bech32Hrp: 'did:vow:',
  lcdUrl: Uri.parse('http://localhost:1317'),
);

final senderMnemonic = ['will', 'hard', ..., 'man'];
final senderWallet = Wallet.derive(senderMnemonic, info);

final recipientMnemonic = ['crisp', 'become', ..., 'cereal'];
final recipientWallet = Wallet.derive(recipientMnemonic, info);
final recipientDid = recipientWallet.bech32Address;

final docId = Uuid().v4();
final checksum = VowDocChecksum(
  value: "a00ab326fc8a3dd93ec84f7e7773ac2499b381c4833e53110107f21c3b90509c",
  algorithm: VowDocChecksumAlgorithm.SHA256,
);
final doSign = VowDoSign(
  storageUri: "http://vowchain.net",
  signerIstance: "did:vow:1cc65t29yuwuc32ep2h9uqhnwrregfq230lf2rj",
  sdnData: {
    VowSdnData.COMMON_NAME,
    VowSdnData.SURNAME,
  },
  vcrId: "xxxxx",
  certificateProfile: "xxxxx",
);

try {
  // --- Share a document
  final response = await DocsHelper.shareDocument(
    id: docId,
    contentUri: 'https://example.com/document',
    metadata: VowDocMetadata(
      contentUri: 'https://example.com/document/metadata',
      schema: VowDocMetadataSchema(
        uri: 'https://example.com/custom/metadata/schema',
        version: '1.0.0',
      ),
    ),
    recipients: [recipientDid],
    wallet: senderWallet,
    checksum: checksum,
    encryptedData: const {VowEncryptedData.CONTENT_URI},
    doSign: doSign,
    fee: const StdFee(
      gas: '200000',
      amount: [StdCoin(denom: 'uvow', amount: '10000')],
    ),
  );

  // --- Send receipt
  final senderDid = senderWallet.bech32Address;

  await DocsHelper.sendDocumentReceipt(
    recipient: senderDid,
    txHash: response.hash,
    documentId: docId,
    wallet: recipientWallet,
  );
} catch (error) {
  // Handle error
}
```
