import 'package:vowchainsdk/entities/docs/vow_doc_receipt.dart';

import 'vow_doc_receipt.dart' as legacy;

class VowDocReceiptMapper {
  static legacy.VowDocReceipt toLegacy(VowDocReceipt docReceipt) {
    return legacy.VowDocReceipt(
      documentUuid: docReceipt.documentUuid,
      recipientDid: docReceipt.recipientDid,
      senderDid: docReceipt.senderDid,
      txHash: docReceipt.txHash,
      uuid: docReceipt.uuid,
      proof: docReceipt.proof ?? '',
    );
  }
}
