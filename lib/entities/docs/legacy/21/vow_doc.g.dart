// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vow_doc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VowDoc _$VowDocFromJson(Map<String, dynamic> json) {
  return VowDoc(
    senderDid: json['sender'] as String,
    recipientDids:
        (json['recipients'] as List<dynamic>).map((e) => e as String).toList(),
    uuid: json['uuid'] as String,
    metadata: VowDocMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    contentUri: json['content_uri'] as String?,
    checksum: json['checksum'] == null
        ? null
        : VowDocChecksum.fromJson(json['checksum'] as Map<String, dynamic>),
    encryptionData: json['encryption_data'] == null
        ? null
        : VowDocEncryptionData.fromJson(
            json['encryption_data'] as Map<String, dynamic>),
    doSign: json['do_sign'] == null
        ? null
        : VowDoSign.fromJson(json['do_sign'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VowDocToJson(VowDoc instance) => <String, dynamic>{
      'sender': instance.senderDid,
      'recipients': instance.recipientDids,
      'uuid': instance.uuid,
      'content_uri': instance.contentUri,
      'metadata': instance.metadata.toJson(),
      'checksum': instance.checksum?.toJson(),
      'encryption_data': instance.encryptionData?.toJson(),
      'do_sign': instance.doSign?.toJson(),
    };

VowDocMetadata _$VowDocMetadataFromJson(Map<String, dynamic> json) {
  return VowDocMetadata(
    contentUri: json['content_uri'] as String,
    schemaType: json['schema_type'] as String,
    schema: json['schema'] == null
        ? null
        : VowDocMetadataSchema.fromJson(json['schema'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VowDocMetadataToJson(VowDocMetadata instance) =>
    <String, dynamic>{
      'content_uri': instance.contentUri,
      'schema_type': instance.schemaType,
      'schema': instance.schema?.toJson(),
    };

VowDocMetadataSchema _$VowDocMetadataSchemaFromJson(Map<String, dynamic> json) {
  return VowDocMetadataSchema(
    uri: json['uri'] as String,
    version: json['version'] as String,
  );
}

Map<String, dynamic> _$VowDocMetadataSchemaToJson(
        VowDocMetadataSchema instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'version': instance.version,
    };

VowDocChecksum _$VowDocChecksumFromJson(Map<String, dynamic> json) {
  return VowDocChecksum(
    value: json['value'] as String,
    algorithm:
        _$enumDecode(_$VowDocChecksumAlgorithmEnumMap, json['algorithm']),
  );
}

Map<String, dynamic> _$VowDocChecksumToJson(VowDocChecksum instance) =>
    <String, dynamic>{
      'value': instance.value,
      'algorithm': _$VowDocChecksumAlgorithmEnumMap[instance.algorithm],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$VowDocChecksumAlgorithmEnumMap = {
  VowDocChecksumAlgorithm.MD5: 'md5',
  VowDocChecksumAlgorithm.SHA1: 'sha-1',
  VowDocChecksumAlgorithm.SHA224: 'sha-224',
  VowDocChecksumAlgorithm.SHA256: 'sha-256',
  VowDocChecksumAlgorithm.SHA384: 'sha-384',
  VowDocChecksumAlgorithm.SHA512: 'sha-512',
};

VowDocEncryptionData _$VowDocEncryptionDataFromJson(Map<String, dynamic> json) {
  return VowDocEncryptionData(
    keys: (json['keys'] as List<dynamic>)
        .map((e) => VowDocEncryptionDataKey.fromJson(e as Map<String, dynamic>))
        .toList(),
    encryptedData: (json['encrypted_data'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$VowDocEncryptionDataToJson(
        VowDocEncryptionData instance) =>
    <String, dynamic>{
      'keys': instance.keys.map((e) => e.toJson()).toList(),
      'encrypted_data': instance.encryptedData,
    };

VowDocEncryptionDataKey _$VowDocEncryptionDataKeyFromJson(
    Map<String, dynamic> json) {
  return VowDocEncryptionDataKey(
    recipientDid: json['recipient'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$VowDocEncryptionDataKeyToJson(
        VowDocEncryptionDataKey instance) =>
    <String, dynamic>{
      'recipient': instance.recipientDid,
      'value': instance.value,
    };

VowDoSign _$VowDoSignFromJson(Map<String, dynamic> json) {
  return VowDoSign(
    storageUri: json['storage_uri'] as String,
    signerIstance: json['signer_instance'] as String,
    vcrId: json['vcr_id'] as String,
    certificateProfile: json['certificate_profile'] as String,
    sdnData: (json['sdn_data'] as List<dynamic>?)
        ?.map((e) => _$enumDecode(_$VowSdnDataEnumMap, e))
        .toList(),
  );
}

Map<String, dynamic> _$VowDoSignToJson(VowDoSign instance) => <String, dynamic>{
      'storage_uri': instance.storageUri,
      'signer_instance': instance.signerIstance,
      'sdn_data': instance.sdnData?.map((e) => _$VowSdnDataEnumMap[e]).toList(),
      'vcr_id': instance.vcrId,
      'certificate_profile': instance.certificateProfile,
    };

const _$VowSdnDataEnumMap = {
  VowSdnData.COMMON_NAME: 'common_name',
  VowSdnData.SURNAME: 'surname',
  VowSdnData.SERIAL_NUMBER: 'serial_number',
  VowSdnData.GIVEN_NAME: 'given_name',
  VowSdnData.ORGANIZATION: 'organization',
  VowSdnData.COUNTRY: 'country',
};
