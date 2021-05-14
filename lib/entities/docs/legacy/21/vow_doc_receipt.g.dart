// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vow_doc_receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VowDocReceipt _$VowDocReceiptFromJson(Map<String, dynamic> json) {
  return VowDocReceipt(
    uuid: json['uuid'] as String,
    senderDid: json['sender'] as String,
    recipientDid: json['recipient'] as String,
    txHash: json['tx_hash'] as String,
    documentUuid: json['document_uuid'] as String,
    proof: json['proof'] as String,
  );
}

Map<String, dynamic> _$VowDocReceiptToJson(VowDocReceipt instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'sender': instance.senderDid,
      'recipient': instance.recipientDid,
      'tx_hash': instance.txHash,
      'document_uuid': instance.documentUuid,
      'proof': instance.proof,
    };
