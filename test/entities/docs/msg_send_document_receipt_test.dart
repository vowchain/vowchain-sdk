import 'package:vowchainsdk/entities/docs/vow_doc_receipt.dart';
import 'package:vowchainsdk/entities/docs/msg_send_document_receipt.dart';
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
  final correctMsgSendDocumentReceipt =
      MsgSendDocumentReceipt(receipt: correctVowDocReceipt);

  test('Type should be "Vow/MsgSendDocumentReceipt"', () {
    expect(
      correctMsgSendDocumentReceipt.type,
      'Vow/MsgSendDocumentReceipt',
    );
  });

  test('Value should the VowDocReceipt json', () {
    expect(
      correctMsgSendDocumentReceipt.value,
      correctVowDocReceipt.toJson(),
    );
  });
}
