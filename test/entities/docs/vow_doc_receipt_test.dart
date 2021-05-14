import 'package:vowchainsdk/entities/docs/vow_doc_receipt.dart';
import 'package:test/test.dart';

void main() {
  final correctVowDocReceipt = VowDocReceipt(
    uuid: 'deeb0998-15fb-4a2f-ba47-e402b9ef0ac5',
    senderDid: 'did:vow:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v',
    recipientDid: 'did:vow:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v',
    txHash: '922CCEE18C8EE1652756F48494B900E3835CDC370113B46D47267FA4C7A0151B',
    documentUuid: '1196e661-bbc2-43da-8184-2ebdcf02053f',
    proof: 'proof',
  );

  test('Props should contains all the object fields', () {
    expect(
      correctVowDocReceipt.props,
      [
        correctVowDocReceipt.uuid,
        correctVowDocReceipt.senderDid,
        correctVowDocReceipt.recipientDid,
        correctVowDocReceipt.txHash,
        correctVowDocReceipt.documentUuid,
        correctVowDocReceipt.proof,
      ],
    );
  });

  group('JSON serialization', () {
    final json = <String, Object>{
      'uuid': correctVowDocReceipt.uuid,
      'sender': correctVowDocReceipt.senderDid,
      'recipient': correctVowDocReceipt.recipientDid,
      'tx_hash': correctVowDocReceipt.txHash,
      'document_uuid': correctVowDocReceipt.documentUuid,
      'proof': correctVowDocReceipt.proof!,
    };

    test('fromJson() shoul behave correctly', () {
      final obj = VowDocReceipt.fromJson(json);

      expect(
        obj.props,
        [
          correctVowDocReceipt.uuid,
          correctVowDocReceipt.senderDid,
          correctVowDocReceipt.recipientDid,
          correctVowDocReceipt.txHash,
          correctVowDocReceipt.documentUuid,
          correctVowDocReceipt.proof,
        ],
      );
    });

    group('toJson() should behave correctly', () {
      test('All fields should be correctly represented', () {
        expect(correctVowDocReceipt.toJson(), json);
      });

      test('Null fields should not be present in json', () {
        final docRecepit = VowDocReceipt(
          uuid: 'deeb0998-15fb-4a2f-ba47-e402b9ef0ac5',
          senderDid: 'did:vow:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v',
          recipientDid: 'did:vow:1zfhgwfgex8rc9t00pk6jm6xj6vx5cjr4ngy32v',
          txHash:
              '922CCEE18C8EE1652756F48494B900E3835CDC370113B46D47267FA4C7A0151B',
          documentUuid: '1196e661-bbc2-43da-8184-2ebdcf02053f',
        );

        final docReceiptJson = docRecepit.toJson();

        expect(docReceiptJson.containsKey('json'), isFalse);
      });
    });
  });
}
