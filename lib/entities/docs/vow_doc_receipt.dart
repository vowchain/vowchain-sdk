import 'package:vowchainsdk/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vow_doc_receipt.g.dart';

/// Represents a document receipt that indicates that the document having
/// the given [documentUuid] present inside the transaction with has [txHash]
/// and sent by [recipientDid] has been received from the [senderDid].
@JsonSerializable(includeIfNull: false)
class VowDocReceipt extends Equatable {
  /// Unique receipt identifier.
  @JsonKey(name: 'uuid')
  final String uuid;

  /// Must be one of the recipients of the shared document.
  @JsonKey(name: 'sender')
  final String senderDid;

  /// The sender of the document.
  @JsonKey(name: 'recipient')
  final String recipientDid;

  /// Transaction hash in which the document has been sent.
  @JsonKey(name: 'tx_hash')
  final String txHash;

  /// The shared document unique identifier.
  @JsonKey(name: 'document_uuid')
  final String documentUuid;

  /// Optional reading proof
  @JsonKey(name: 'proof')
  final String? proof;

  VowDocReceipt({
    required this.uuid,
    required this.senderDid,
    required this.recipientDid,
    required this.txHash,
    required this.documentUuid,
    this.proof,
  })  : assert(matchUuidv4(uuid)),
        assert(matchBech32Format(senderDid)),
        assert(matchBech32Format(recipientDid)),
        assert(matchUuidv4(documentUuid));

  @override
  List<Object?> get props {
    return [uuid, senderDid, recipientDid, txHash, documentUuid, proof];
  }

  factory VowDocReceipt.fromJson(Map<String, dynamic> json) =>
      _$VowDocReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$VowDocReceiptToJson(this);
}
