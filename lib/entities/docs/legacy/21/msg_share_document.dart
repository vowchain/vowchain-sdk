import 'package:vowchainsdk/export.dart';

import 'vow_doc.dart' as legacy;

/// Represents the transaction message that must be used when wanting to
/// share a document from one user to another one.
class MsgShareDocument extends StdMsg {
  final legacy.VowDoc document;

  MsgShareDocument({
    required this.document,
  }) : super(type: 'Vow/MsgShareDocument', value: <String, String>{});

  @override
  Map<String, dynamic> get value => document.toJson();
}
