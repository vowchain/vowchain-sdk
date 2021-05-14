import 'package:vowchainsdk/entities/docs/vow_doc.dart';

import 'vow_doc.dart' as legacy;

class VowDocMapper {
  /// Converts the provided [VowDoc] and returns a [legacy.VowDoc]
  /// version compatible with a 2.1 chain.
  static legacy.VowDoc toLegacy(VowDoc VowDoc) {
    legacy.VowDocMetadataSchema? metadataSchema;

    if (VowDoc.metadata.schema != null) {
      metadataSchema = legacy.VowDocMetadataSchema(
        uri: VowDoc.metadata.schema!.uri,
        version: VowDoc.metadata.schema!.version,
      );
    }

    final metadata = legacy.VowDocMetadata(
      contentUri: VowDoc.metadata.contentUri,
      schema: metadataSchema,
      schemaType: VowDoc.metadata.schemaType ?? '',
    );

    legacy.VowDocChecksum? checksum;

    if (VowDoc.checksum != null) {
      checksum = legacy.VowDocChecksum(
        algorithm: _checksumAlgorithmToLegacy(VowDoc.checksum!.algorithm),
        value: VowDoc.checksum!.value,
      );
    }

    legacy.VowDoSign? doSign;

    if (VowDoc.doSign != null) {
      doSign = legacy.VowDoSign(
        certificateProfile: VowDoc.doSign!.certificateProfile,
        signerIstance: VowDoc.doSign!.signerIstance,
        storageUri: VowDoc.doSign!.storageUri,
        vcrId: VowDoc.doSign!.vcrId,
        sdnData:
            VowDoc.doSign!.sdnData?.map((e) => _sdnDataToLegacy(e)).toList(),
      );
    }

    legacy.VowDocEncryptionData? encryptionData;

    if (VowDoc.encryptionData != null) {
      encryptionData = legacy.VowDocEncryptionData(
        encryptedData:
            VowDoc.encryptionData!.encryptedData.map((e) => e.value).toList(),
        keys: VowDoc.encryptionData!.keys
            .map((e) => _encryptionDataKeyToLegacy(e))
            .toList(),
      );
    }

    return legacy.VowDoc(
      senderDid: VowDoc.senderDid,
      recipientDids: VowDoc.recipientDids,
      uuid: VowDoc.uuid,
      metadata: metadata,
      contentUri: VowDoc.contentUri,
      checksum: checksum,
      doSign: doSign,
      encryptionData: encryptionData,
    );
  }

  static legacy.VowDocChecksumAlgorithm _checksumAlgorithmToLegacy(
    VowDocChecksumAlgorithm algorithm,
  ) {
    switch (algorithm) {
      case VowDocChecksumAlgorithm.MD5:
        return legacy.VowDocChecksumAlgorithm.MD5;
      case VowDocChecksumAlgorithm.SHA1:
        return legacy.VowDocChecksumAlgorithm.SHA1;
      case VowDocChecksumAlgorithm.SHA224:
        return legacy.VowDocChecksumAlgorithm.SHA224;
      case VowDocChecksumAlgorithm.SHA256:
        return legacy.VowDocChecksumAlgorithm.SHA256;
      case VowDocChecksumAlgorithm.SHA384:
        return legacy.VowDocChecksumAlgorithm.SHA384;
      case VowDocChecksumAlgorithm.SHA512:
        return legacy.VowDocChecksumAlgorithm.SHA512;
      default:
        throw ArgumentError('Unsupported algorithm $algorithm');
    }
  }

  static legacy.VowSdnData _sdnDataToLegacy(VowSdnData sdnData) {
    switch (sdnData) {
      case VowSdnData.COMMON_NAME:
        return legacy.VowSdnData.COMMON_NAME;
      case VowSdnData.COUNTRY:
        return legacy.VowSdnData.COUNTRY;
      case VowSdnData.GIVEN_NAME:
        return legacy.VowSdnData.GIVEN_NAME;
      case VowSdnData.ORGANIZATION:
        return legacy.VowSdnData.ORGANIZATION;
      case VowSdnData.SERIAL_NUMBER:
        return legacy.VowSdnData.SERIAL_NUMBER;
      case VowSdnData.SURNAME:
        return legacy.VowSdnData.SURNAME;
      default:
        throw ArgumentError('Unsupported SdnData $sdnData');
    }
  }

  static legacy.VowDocEncryptionDataKey _encryptionDataKeyToLegacy(
    VowDocEncryptionDataKey dataKey,
  ) {
    return legacy.VowDocEncryptionDataKey(
      recipientDid: dataKey.recipientDid,
      value: dataKey.value,
    );
  }
}
