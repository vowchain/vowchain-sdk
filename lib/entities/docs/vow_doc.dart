import 'package:vowchainsdk/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vow_doc.g.dart';

/// Contains all the data related to a document that is sent to the chain when
/// a user wants to share a document with another user.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
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

  /// If [doSign] is specified then the field [checksum] must be also provided.
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
  })  : assert(matchBech32Format(senderDid)),
        assert(recipientDids.isNotEmpty &&
            recipientDids.every((e) => matchBech32Format(e))),
        assert(matchUuidv4(uuid)),
        assert(contentUri == null || checkStringBytesLen(contentUri, 512)),
        assert(_checksumMustBePresentIfDoSign(checksum, doSign));

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VowDocMetadata extends Equatable {
  @JsonKey(name: 'content_uri')
  final String contentUri;

  @JsonKey(name: 'schema_type')
  final String? schemaType;

  @JsonKey(name: 'schema')
  final VowDocMetadataSchema? schema;

  VowDocMetadata({
    required this.contentUri,
    this.schemaType,
    this.schema,
  })  : assert(checkStringBytesLen(contentUri, 512)),
        assert((schemaType != null &&
                schemaType.isNotEmpty &&
                checkStringBytesLen(schemaType, 512)) ||
            schema != null);

  @override
  List<Object?> get props {
    return [contentUri, schema, schemaType];
  }

  factory VowDocMetadata.fromJson(Map<String, dynamic> json) =>
      _$VowDocMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$VowDocMetadataToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VowDocMetadataSchema extends Equatable {
  @JsonKey(name: 'uri')
  final String uri;

  @JsonKey(name: 'version')
  final String version;

  VowDocMetadataSchema({
    required this.uri,
    required this.version,
  })   : assert(uri.isNotEmpty && checkStringBytesLen(uri, 512)),
        assert(uri.isNotEmpty && checkStringBytesLen(version, 32));

  @override
  List<Object> get props {
    return [uri, version];
  }

  factory VowDocMetadataSchema.fromJson(Map<String, dynamic> json) =>
      _$VowDocMetadataSchemaFromJson(json);

  Map<String, dynamic> toJson() => _$VowDocMetadataSchemaToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VowDocChecksum extends Equatable {
  @JsonKey(name: 'value')
  final String value;

  @JsonKey(name: 'algorithm')
  final VowDocChecksumAlgorithm algorithm;

  VowDocChecksum({
    required this.value,
    required this.algorithm,
  }) : assert(value.isNotEmpty);

  @override
  List<Object> get props {
    return [value, algorithm];
  }

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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VowDocEncryptionData extends Equatable {
  @JsonKey(name: 'keys')
  final List<VowDocEncryptionDataKey> keys;

  @JsonKey(name: 'encrypted_data')
  final Set<VowEncryptedData> encryptedData;

  const VowDocEncryptionData({
    required this.keys,
    required this.encryptedData,
  });

  @override
  List<Object> get props {
    return [keys, encryptedData];
  }

  factory VowDocEncryptionData.fromJson(Map<String, dynamic> json) =>
      _$VowDocEncryptionDataFromJson(json);

  Map<String, dynamic> toJson() => _$VowDocEncryptionDataToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VowDocEncryptionDataKey extends Equatable {
  @JsonKey(name: 'recipient')
  final String recipientDid;

  @JsonKey(name: 'value')
  final String value;

  VowDocEncryptionDataKey({
    required this.recipientDid,
    required this.value,
  }) : assert(checkStringBytesLen(value, 512));

  @override
  List<Object> get props {
    return [recipientDid, value];
  }

  factory VowDocEncryptionDataKey.fromJson(Map<String, dynamic> json) =>
      _$VowDocEncryptionDataKeyFromJson(json);

  Map<String, dynamic> toJson() => _$VowDocEncryptionDataKeyToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class VowDoSign extends Equatable {
  @JsonKey(name: 'storage_uri')
  final String storageUri;

  @JsonKey(name: 'signer_instance')
  final String signerIstance;

  @JsonKey(name: 'sdn_data', includeIfNull: true)
  final Set<VowSdnData>? sdnData;

  @JsonKey(name: 'vcr_id')
  final String vcrId;

  @JsonKey(name: 'certificate_profile')
  final String certificateProfile;

  VowDoSign({
    required this.storageUri,
    required this.signerIstance,
    required this.vcrId,
    required this.certificateProfile,
    this.sdnData,
  })  : assert(checkStringBytesLen(vcrId, 64)),
        assert(checkStringBytesLen(certificateProfile, 32)),
        assert(_sdnDataNotEmpty(sdnData));

  @override
  List<Object?> get props {
    return [storageUri, signerIstance, sdnData, vcrId, certificateProfile];
  }

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

// For more information see:
/// https://docs.vowchain.net/x/docs/#supported-encrypted-data
enum VowEncryptedData {
  /// Special identifier, references the document's file contents. Means that
  /// the `aes_key` has been used to encrypt a file exchanged by other means of
  /// communication.
  @JsonValue('content')
  CONTENT,

  /// The value of the field `content_uri` must be encrypted.
  @JsonValue('content_uri')
  CONTENT_URI,

  /// The value of the field `content_uri` inside the `metadata` must be
  /// encrypted.
  @JsonValue('metadata.content_uri')
  METADATA_CONTENT_URI,

  /// The value of the field `uri` inside the `schema` inside `metadata` must be
  /// encrypted.
  @JsonValue('metadata.schema.uri')
  METADATA_SCHEMA_URI,
}

extension VowEncryptedDataExt on VowEncryptedData {
  /// Returns the string representation of the [EncryptedData] enum.
  String get value {
    switch (this) {
      case VowEncryptedData.CONTENT:
        return 'content';
      case VowEncryptedData.CONTENT_URI:
        return 'content_uri';
      case VowEncryptedData.METADATA_CONTENT_URI:
        return 'metadata.content_uri';
      case VowEncryptedData.METADATA_SCHEMA_URI:
        return 'metadata.schema.uri';
    }
  }

  /// Returns the [EncryptedData] that corresponds to the [value] or [null] if
  /// the [value] is not valid.
  static VowEncryptedData fromValue(String value) {
    switch (value) {
      case 'content':
        return VowEncryptedData.CONTENT;
      case 'content_uri':
        return VowEncryptedData.CONTENT_URI;
      case 'metadata.content_uri':
        return VowEncryptedData.METADATA_CONTENT_URI;
      case 'metadata.schema.uri':
        return VowEncryptedData.METADATA_SCHEMA_URI;
      default:
        throw ArgumentError(
            'Invalid argument $value. Valid values are "content", "content_uri", "metadata.content_uri" and "metadata.schema.uri"');
    }
  }
}

/// Return [true] if the fields [doSign] and [checksum] are both not null if the
/// first is specified.
bool _checksumMustBePresentIfDoSign(
  VowDocChecksum? checksum,
  VowDoSign? doSign,
) {
  return doSign != null ? checksum != null : true;
}

/// Returns [true] if [sdnData] is [null] or, if specified, must be not empty.
bool _sdnDataNotEmpty(Set<VowSdnData>? sdnData) {
  return sdnData != null ? sdnData.isNotEmpty : true;
}
