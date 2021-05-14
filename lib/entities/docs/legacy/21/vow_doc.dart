import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vow_doc.g.dart';

/// Contains all the data related to a document that is sent to the chain when
/// a user wants to share a document with another user.
@JsonSerializable(explicitToJson: true)
class VowDoc extends Equatable {
  @JsonKey(name: 'sender')
  final String senderDid;

  @JsonKey(name: 'recipients')
  final List<String> recipientDids;

  @JsonKey(name: 'uuid')
  final String uuid;

  @JsonKey(name: 'content_uri')
  final String? contentUri;

  @JsonKey(name: 'metadata')
  final VowDocMetadata metadata;

  @JsonKey(name: 'checksum')
  final VowDocChecksum? checksum;

  @JsonKey(name: 'encryption_data')
  final VowDocEncryptionData? encryptionData;

  @JsonKey(name: 'do_sign')
  final VowDoSign? doSign;

  VowDoc({
    required this.senderDid,
    required this.recipientDids,
    required this.uuid,
    required this.metadata,
    this.contentUri,
    this.checksum,
    this.encryptionData,
    this.doSign,
  }) : assert(recipientDids.isNotEmpty);

  @override
  List<Object?> get props {
    return [
      uuid,
      senderDid,
      recipientDids,
      contentUri,
      metadata,
      checksum,
      encryptionData,
      doSign,
    ];
  }

  factory VowDoc.fromJson(Map<String, dynamic> json) => _$VowDocFromJson(json);

  Map<String, dynamic> toJson() => _$VowDocToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VowDocMetadata extends Equatable {
  @JsonKey(name: 'content_uri')
  final String contentUri;

  @JsonKey(name: 'schema_type')
  final String schemaType;

  @JsonKey(name: 'schema')
  final VowDocMetadataSchema? schema;

  VowDocMetadata({
    required this.contentUri,
    this.schemaType = '',
    this.schema,
  }) : assert(schemaType.isNotEmpty || schema != null);

  @override
  List<Object?> get props => [contentUri, schema, schemaType];

  factory VowDocMetadata.fromJson(Map<String, dynamic> json) =>
      _$VowDocMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$VowDocMetadataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VowDocMetadataSchema extends Equatable {
  @JsonKey(name: 'uri')
  final String uri;

  @JsonKey(name: 'version')
  final String version;

  const VowDocMetadataSchema({
    required this.uri,
    required this.version,
  });

  @override
  List<Object> get props => [uri, version];

  factory VowDocMetadataSchema.fromJson(Map<String, dynamic> json) =>
      _$VowDocMetadataSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$VowDocMetadataSchemaToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VowDocChecksum extends Equatable {
  @JsonKey(name: 'value')
  final String value;

  @JsonKey(name: 'algorithm')
  final VowDocChecksumAlgorithm algorithm;

  const VowDocChecksum({
    required this.value,
    required this.algorithm,
  });

  @override
  List<Object> get props => [value, algorithm];

  factory VowDocChecksum.fromJson(Map<String, dynamic> json) =>
      _$VowDocChecksumFromJson(json);

  Map<String, dynamic> toJson() => _$VowDocChecksumToJson(this);
}

enum VowDocChecksumAlgorithm {
  @JsonValue('md5')
  MD5,

  @JsonValue('sha-1')
  SHA1,

  @JsonValue('sha-224')
  SHA224,

  @JsonValue('sha-256')
  SHA256,

  @JsonValue('sha-384')
  SHA384,

  @JsonValue('sha-512')
  SHA512,
}

@JsonSerializable(explicitToJson: true)
class VowDocEncryptionData extends Equatable {
  @JsonKey(name: 'keys')
  final List<VowDocEncryptionDataKey> keys;

  @JsonKey(name: 'encrypted_data')
  final List<String> encryptedData;

  const VowDocEncryptionData({
    required this.keys,
    required this.encryptedData,
  });

  @override
  List<Object> get props => [keys, encryptedData];

  factory VowDocEncryptionData.fromJson(Map<String, dynamic> json) =>
      _$VowDocEncryptionDataFromJson(json);

  Map<String, dynamic> toJson() => _$VowDocEncryptionDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VowDocEncryptionDataKey extends Equatable {
  @JsonKey(name: 'recipient')
  final String recipientDid;

  @JsonKey(name: 'value')
  final String value;

  const VowDocEncryptionDataKey({
    required this.recipientDid,
    required this.value,
  });

  @override
  List<Object> get props => [recipientDid, value];

  factory VowDocEncryptionDataKey.fromJson(Map<String, dynamic> json) =>
      _$VowDocEncryptionDataKeyFromJson(json);

  Map<String, dynamic> toJson() => _$VowDocEncryptionDataKeyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VowDoSign extends Equatable {
  @JsonKey(name: 'storage_uri')
  final String storageUri;

  @JsonKey(name: 'signer_instance')
  final String signerIstance;

  @JsonKey(name: 'sdn_data')
  final List<VowSdnData>? sdnData;

  @JsonKey(name: 'vcr_id')
  final String vcrId;

  @JsonKey(name: 'certificate_profile')
  final String certificateProfile;

  const VowDoSign({
    required this.storageUri,
    required this.signerIstance,
    required this.vcrId,
    required this.certificateProfile,
    this.sdnData,
  });

  @override
  List<Object?> get props =>
      [storageUri, signerIstance, sdnData, vcrId, certificateProfile];

  factory VowDoSign.fromJson(Map<String, dynamic> json) =>
      _$VowDoSignFromJson(json);

  Map<String, dynamic> toJson() => _$VowDoSignToJson(this);
}

enum VowSdnData {
  @JsonValue('common_name')
  COMMON_NAME,

  @JsonValue('surname')
  SURNAME,

  @JsonValue('serial_number')
  SERIAL_NUMBER,

  @JsonValue('given_name')
  GIVEN_NAME,

  @JsonValue('organization')
  ORGANIZATION,

  @JsonValue('country')
  COUNTRY,
}
