import 'package:vowchainsdk/export.dart';

import 'vow_doc_receipt.dart' as legacy;

/// Message that should be used when wanting to send a document
/// receipt transaction.
class MsgSendDocumentReceipt extends StdMsg {
  final legacy.VowDocReceipt receipt;

  MsgSendDocumentReceipt({required this.receipt})
      : super(type: 'Vow/MsgSendDocumentReceipt', value: <String, String>{});

  @override
  Map<String, dynamic> get value => receipt.toJson();
}
