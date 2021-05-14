import 'package:vowchainsdk/entities/docs/vow_doc.dart';
import 'package:test/test.dart';

void main() {
  final correctVowDocMetadataSchema = VowDocMetadataSchema(
    uri: 'http://uri.url',
    version: '1',
  );
  final correctMetadata = VowDocMetadata(
    contentUri: 'content-uri',
    schemaType: 'schemaType',
    schema: correctVowDocMetadataSchema,
  );
  const correctDid = 'did:vow:1acdefg';
  const correctUuid = 'c510755c-c27d-4348-bf4c-f6050fc6935c';
  const invalid520CharactersString =
      'qYxEIgza4dfuLGka6ULnNLv8PArpjjuLoipUyoi2xon3sHAcufys3o89jRYUuGlDs68qd1NsJKAxC11InzFJBXYMaOYHFniELo2OfRN52SQReR1sShgwX5oQboUc38yITigc6pw4oBOMlz895pChLfXDAHDQSon9D11hc7AX4QkGqWxH5gdvZgrkRxTDckMJCC0mhxWi9brwwgLeTqH3sjwmVPDB5KDGMw1inp8oRSn563TEKPqd1Pp1pb06N81pI2ACkPKnLpDvYVE75vCITq8FhBBlV3neuSg5ktfAjaZ3byev0MsnPv2gwakpSgNWbVAumEA0OJuzsYDytBhUIyAM9zTpKVoVOYzks4W7jRHdiiqXs7OiyXCrgQwVyKDW1eAM9NYexYf9dUfnYja4RxVP0GSIhefun39LgrgpNDjvq2Cbrx296WGt6GLUKDxhqScPmVkvmSzT7ULklJztrA3oE3ooNVSWbq5ir772lKiuhhtFZEaPWSGeeHdmWodQoOWFFWfC';
  const invalid33CharsString = 'bKWAUWc2oBRIxFjIJrGFrT9RohFC4hXLe';
  const invalid65CharsString =
      '9S9BRIhrhaGcUvoothkdkvcil1a1Kn9AROHh4hLRCxSmZbDbfYy2NP5NjpaAQH1iX';
  final correctVowDocEncryptionDataKey = VowDocEncryptionDataKey(
    recipientDid: correctDid,
    value: 'value',
  );
  final correctVowDocChecksum = VowDocChecksum(
    value: 'value',
    algorithm: VowDocChecksumAlgorithm.MD5,
  );
  final correctVowDoSign = VowDoSign(
    storageUri: 'http://do.sign',
    signerIstance: 'signer',
    vcrId: 'vcrId',
    certificateProfile: 'profile',
    sdnData: const {VowSdnData.COMMON_NAME},
  );
  final correctVowEncryptionData = VowDocEncryptionData(
    keys: [correctVowDocEncryptionDataKey],
    encryptedData: const {VowEncryptedData.CONTENT_URI},
  );
  final correctVowDoc = VowDoc(
    senderDid: correctDid,
    recipientDids: const [correctDid],
    uuid: correctUuid,
    metadata: correctMetadata,
    contentUri: 'content-uri',
    checksum: correctVowDocChecksum,
    doSign: correctVowDoSign,
    encryptionData: correctVowEncryptionData,
  );

  group('VowDoc', () {
    test('Bech32 addresses should have a valid format', () {
      // Empty did string

      expect(
        () => VowDoc(
          senderDid: '',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => VowDoc(
          senderDid: correctDid,
          recipientDids: const [''],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // Malformed strings

      expect(
        () => VowDoc(
          senderDid: 'did:com',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => VowDoc(
          senderDid: correctDid,
          recipientDids: const ['did:com'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // Missing 1 as separator

      expect(
        () => VowDoc(
          senderDid: 'did:vow:abcdefg',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => VowDoc(
          senderDid: correctDid,
          recipientDids: const ['did:vow:abcdefg'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // Too short strings

      expect(
        () => VowDoc(
          senderDid: 'a1c',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => VowDoc(
          senderDid: correctDid,
          recipientDids: const ['a1c'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // Too long strings

      expect(
        () => VowDoc(
          senderDid:
              'Y3UexQW1ZC6uXcM0ux58mnR3x4zvYaHAEA05DaC03CTcw0mmE0CaK89YD6CHmEUa05k57Dh0506CMUdNzn7QVvgYS80a5Q75lzQK',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => VowDoc(
          senderDid: correctDid,
          recipientDids: const [
            'Y3UexQW1ZC6uXcM0ux58mnR3x4zvYaHAEA05DaC03CTcw0mmE0CaK89YD6CHmEUa05k57Dh0506CMUdNzn7QVvgYS80a5Q75lzQK'
          ],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // The character b must not be contained

      expect(
        () => VowDoc(
          senderDid: 'did:vow:1abcdef',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => VowDoc(
          senderDid: correctDid,
          recipientDids: const ['did:vow:1abcdef'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // The character i must not be contained

      expect(
        () => VowDoc(
          senderDid: 'did:vow:1aicdefg',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => VowDoc(
          senderDid: correctDid,
          recipientDids: const ['did:vow:1aicdefg'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      // The character o must not be contained

      expect(
        () => VowDoc(
          senderDid: 'did:vow:1aocdefg',
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );

      expect(
        () => VowDoc(
          senderDid: correctDid,
          recipientDids: const ['did:vow:1aocdefg'],
          uuid: correctUuid,
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('UUID must have a valid UUID v4 format', () {
      expect(
        () => VowDoc(
          senderDid: correctDid,
          recipientDids: const [correctDid],
          uuid: 'a1b2c3d4',
          metadata: correctMetadata,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('If contentUri is provided it should be < 512 bytes len', () {
      expect(
        () => VowDoc(
          senderDid: correctDid,
          recipientDids: const [correctDid],
          uuid: correctUuid,
          metadata: correctMetadata,
          contentUri: invalid520CharactersString,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Props should contains all the object fields', () {
      expect(
        correctVowDoc.props,
        [
          correctVowDoc.uuid,
          correctVowDoc.senderDid,
          correctVowDoc.recipientDids,
          correctVowDoc.contentUri,
          correctVowDoc.metadata,
          correctVowDoc.checksum,
          correctVowDoc.encryptionData,
          correctVowDoc.doSign,
        ],
      );
    });

    group('JSON serialization', () {
      final jsonMinimal = <String, Object>{
        'sender': correctVowDoc.senderDid,
        'recipients': correctVowDoc.recipientDids,
        'uuid': correctVowDoc.uuid,
        'metadata': correctVowDoc.metadata.toJson(),
      };

      final jsonWithContentUri = Map<String, Object>.from(jsonMinimal)
        ..addAll({'content_uri': correctVowDoc.contentUri!});

      final jsonWithChecksum = Map<String, Object>.from(jsonMinimal)
        ..addAll({'checksum': correctVowDoc.checksum!.toJson()});

      final jsonWithEncryptionData = Map<String, Object>.from(jsonMinimal)
        ..addAll({
          'encryption_data': correctVowDoc.encryptionData!.toJson(),
        });

      final jsonWithDoSign = Map<String, Object>.from(jsonMinimal)
        ..addAll({'do_sign': correctVowDoc.doSign!.toJson()})
        ..addAll({'checksum': correctVowDocChecksum.toJson()});

      test('fromJson() shoul behave correctly', () {
        final obj = VowDoc.fromJson(jsonMinimal);
        expect(
          obj.props,
          [
            correctVowDoc.uuid,
            correctVowDoc.senderDid,
            correctVowDoc.recipientDids,
            null,
            correctVowDoc.metadata,
            null,
            null,
            null,
          ],
        );

        final obj2 = VowDoc.fromJson(jsonWithContentUri);
        expect(
          obj2.props,
          [
            correctVowDoc.uuid,
            correctVowDoc.senderDid,
            correctVowDoc.recipientDids,
            correctVowDoc.contentUri,
            correctVowDoc.metadata,
            null,
            null,
            null,
          ],
        );

        final obj3 = VowDoc.fromJson(jsonWithChecksum);
        expect(
          obj3.props,
          [
            correctVowDoc.uuid,
            correctVowDoc.senderDid,
            correctVowDoc.recipientDids,
            null,
            correctVowDoc.metadata,
            correctVowDoc.checksum,
            null,
            null,
          ],
        );

        final obj4 = VowDoc.fromJson(jsonWithEncryptionData);
        expect(
          obj4.props,
          [
            correctVowDoc.uuid,
            correctVowDoc.senderDid,
            correctVowDoc.recipientDids,
            null,
            correctVowDoc.metadata,
            null,
            correctVowDoc.encryptionData,
            null,
          ],
        );

        final obj5 = VowDoc.fromJson(jsonWithDoSign);
        expect(
          obj5.props,
          [
            correctVowDoc.uuid,
            correctVowDoc.senderDid,
            correctVowDoc.recipientDids,
            null,
            correctVowDoc.metadata,
            correctVowDocChecksum,
            null,
            correctVowDoc.doSign,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        final minimalDoc = VowDoc(
          uuid: correctVowDoc.uuid,
          senderDid: correctVowDoc.senderDid,
          recipientDids: correctVowDoc.recipientDids,
          metadata: correctVowDoc.metadata,
        );
        expect(minimalDoc.toJson(), jsonMinimal);

        final docWithContentUri = VowDoc(
          uuid: correctVowDoc.uuid,
          senderDid: correctVowDoc.senderDid,
          recipientDids: correctVowDoc.recipientDids,
          metadata: correctVowDoc.metadata,
          contentUri: correctVowDoc.contentUri,
        );
        expect(docWithContentUri.toJson(), jsonWithContentUri);

        final docWithChecksum = VowDoc(
          uuid: correctVowDoc.uuid,
          senderDid: correctVowDoc.senderDid,
          recipientDids: correctVowDoc.recipientDids,
          metadata: correctVowDoc.metadata,
          checksum: correctVowDoc.checksum,
        );
        expect(docWithChecksum.toJson(), jsonWithChecksum);

        final docWithEncryptionData = VowDoc(
          uuid: correctVowDoc.uuid,
          senderDid: correctVowDoc.senderDid,
          recipientDids: correctVowDoc.recipientDids,
          metadata: correctVowDoc.metadata,
          encryptionData: correctVowDoc.encryptionData,
        );
        expect(docWithEncryptionData.toJson(), jsonWithEncryptionData);

        final docWithDoSign = VowDoc(
          uuid: correctVowDoc.uuid,
          senderDid: correctVowDoc.senderDid,
          recipientDids: correctVowDoc.recipientDids,
          metadata: correctVowDoc.metadata,
          doSign: correctVowDoc.doSign,
          checksum: correctVowDoc.checksum,
        );
        expect(docWithDoSign.toJson(), jsonWithDoSign);
      });
    });
  });

  group('VowDocMetadata', () {
    test('contentUri should be < 512 bytes len', () {
      expect(
        () => VowDocMetadata(contentUri: invalid520CharactersString),
        throwsA(isA<AssertionError>()),
      );
    });

    test('At least one of schemaType or schema should not be null', () {
      expect(
        () => VowDocMetadata(contentUri: 'content-uri', schema: null),
        throwsA(isA<AssertionError>()),
      );
      expect(
        () => VowDocMetadata(contentUri: 'content-uri', schemaType: null),
        throwsA(isA<AssertionError>()),
      );
    });

    test('schemaType should not be empty', () {
      expect(
        () => VowDocMetadata(contentUri: 'content-uri', schemaType: ''),
        throwsA(isA<AssertionError>()),
      );
    });

    test('schemaType should be < 512 bytes len', () {
      expect(
        () => VowDocMetadata(
          contentUri: 'content-uri',
          schemaType: invalid520CharactersString,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Props should contains all the object fields', () {
      expect(
        correctMetadata.props,
        [
          correctMetadata.contentUri,
          correctMetadata.schema,
          correctMetadata.schemaType,
        ],
      );
    });

    group('JSON serialization', () {
      final jsonWithSchemaType = <String, Object>{
        'content_uri': correctMetadata.contentUri,
        'schema_type': correctMetadata.schemaType!,
      };

      final jsonWithSchema = <String, Object>{
        'content_uri': correctMetadata.contentUri,
        'schema': {
          'uri': correctMetadata.schema!.uri,
          'version': correctMetadata.schema!.version,
        },
      };

      test('fromJson() shoul behave correctly', () {
        final obj = VowDocMetadata.fromJson(jsonWithSchemaType);
        expect(
          obj.props,
          [
            correctMetadata.contentUri,
            null,
            correctMetadata.schemaType,
          ],
        );

        final obj2 = VowDocMetadata.fromJson(jsonWithSchema);
        expect(
          obj2.props,
          [
            correctMetadata.contentUri,
            correctMetadata.schema,
            null,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        final metadataWithSchemaType = VowDocMetadata(
          contentUri: correctMetadata.contentUri,
          schemaType: correctMetadata.schemaType,
        );
        expect(metadataWithSchemaType.toJson(), jsonWithSchemaType);

        final metadataWithSchema = VowDocMetadata(
          contentUri: correctMetadata.contentUri,
          schema: correctMetadata.schema,
        );
        expect(metadataWithSchema.toJson(), jsonWithSchema);
      });
    });
  });

  group('VowDocMetadataSchema', () {
    test('uri should be <= 512 bytes len', () {
      expect(
        () => VowDocMetadataSchema(
          uri: invalid520CharactersString,
          version: '1',
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('version should be <= 32 bytes len', () {
      expect(
        () => VowDocMetadataSchema(
          uri: 'http://example.com/',
          version: invalid33CharsString,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Props should contains all the object fields', () {
      expect(
        correctVowDocMetadataSchema.props,
        [
          correctVowDocMetadataSchema.uri,
          correctVowDocMetadataSchema.version,
        ],
      );
    });

    group('JSON serialization', () {
      final json = <String, Object>{
        'uri': correctVowDocMetadataSchema.uri,
        'version': correctVowDocMetadataSchema.version,
      };

      test('fromJson() shoul behave correctly', () {
        final obj = VowDocMetadataSchema.fromJson(json);

        expect(
          obj.props,
          [
            correctVowDocMetadataSchema.uri,
            correctVowDocMetadataSchema.version,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        expect(correctVowDocMetadataSchema.toJson(), json);
      });
    });
  });

  group('VowDocChecksum', () {
    test('Props should contains all the object fields', () {
      expect(
        correctVowDocChecksum.props,
        [
          correctVowDocChecksum.value,
          correctVowDocChecksum.algorithm,
        ],
      );
    });

    group('JSON serialization', () {
      final json = <String, Object>{
        'value': correctVowDocChecksum.value,
        'algorithm': 'md5',
      };

      test('fromJson() shoul behave correctly', () {
        final obj = VowDocChecksum.fromJson(json);

        expect(
          obj.props,
          [
            correctVowDocChecksum.value,
            correctVowDocChecksum.algorithm,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        expect(correctVowDocChecksum.toJson(), json);
      });
    });
  });

  group('VowDocEncryptionData', () {
    test('Props should contains all the object fields', () {
      expect(
        correctVowEncryptionData.props,
        [
          correctVowEncryptionData.keys,
          correctVowEncryptionData.encryptedData,
        ],
      );
    });

    group('JSON serialization', () {
      final json = <String, Object>{
        'recipient': correctVowDocEncryptionDataKey.recipientDid,
        'value': correctVowDocEncryptionDataKey.value,
      };

      test('fromJson() shoul behave correctly', () {
        final obj = VowDocEncryptionDataKey.fromJson(json);

        expect(
          obj.props,
          [
            correctVowDocEncryptionDataKey.recipientDid,
            correctVowDocEncryptionDataKey.value,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        expect(correctVowDocEncryptionDataKey.toJson(), json);
      });
    });
  });

  group('VowDocEncryptionDataKey', () {
    test('value lenght should be <= 512 bytes', () {
      expect(
        () => VowDocEncryptionDataKey(
          recipientDid: correctDid,
          value: invalid520CharactersString,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Props should contains all the object fields', () {
      expect(
        correctVowDocEncryptionDataKey.props,
        [
          correctVowDocEncryptionDataKey.recipientDid,
          correctVowDocEncryptionDataKey.value,
        ],
      );
    });

    group('JSON serialization', () {
      final json = <String, Object>{
        'recipient': correctVowDocEncryptionDataKey.recipientDid,
        'value': correctVowDocEncryptionDataKey.value,
      };

      test('fromJson() shoul behave correctly', () {
        final obj = VowDocEncryptionDataKey.fromJson(json);

        expect(
          obj.props,
          [
            correctVowDocEncryptionDataKey.recipientDid,
            correctVowDocEncryptionDataKey.value,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        expect(correctVowDocEncryptionDataKey.toJson(), json);
      });
    });
  });

  group('VowDoSign', () {
    test('vcrId length should be <= 64 bytes', () {
      expect(
        () => VowDoSign(
          certificateProfile: '',
          signerIstance: '',
          storageUri: '',
          vcrId: invalid65CharsString,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('certificateProfile length should be <= 32 bytes', () {
      expect(
        () => VowDoSign(
          certificateProfile: invalid33CharsString,
          signerIstance: '',
          storageUri: '',
          vcrId: '',
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test('Props should contains all the object fields', () {
      expect(
        correctVowDoSign.props,
        [
          correctVowDoSign.storageUri,
          correctVowDoSign.signerIstance,
          correctVowDoSign.sdnData,
          correctVowDoSign.vcrId,
          correctVowDoSign.certificateProfile,
        ],
      );
    });

    group('JSON serialization', () {
      final minimalJson = <String, Object?>{
        'storage_uri': correctVowDoSign.storageUri,
        'signer_instance': correctVowDoSign.signerIstance,
        'vcr_id': correctVowDoSign.vcrId,
        'certificate_profile': correctVowDoSign.certificateProfile,
        'sdn_data': null,
      };

      final json2 = Map<String, Object?>.from(minimalJson);
      json2['sdn_data'] = ['common_name'];

      test('fromJson() shoul behave correctly', () {
        final minimalDoSign = VowDoSign.fromJson(minimalJson);

        expect(
          minimalDoSign.props,
          [
            correctVowDoSign.storageUri,
            correctVowDoSign.signerIstance,
            null,
            correctVowDoSign.vcrId,
            correctVowDoSign.certificateProfile,
          ],
        );

        final doSign2 = VowDoSign.fromJson(json2);

        expect(
          doSign2.props,
          [
            correctVowDoSign.storageUri,
            correctVowDoSign.signerIstance,
            correctVowDoSign.sdnData,
            correctVowDoSign.vcrId,
            correctVowDoSign.certificateProfile,
          ],
        );
      });

      test('toJson() should behave correctly', () {
        final minDoSign = VowDoSign(
          storageUri: correctVowDoSign.storageUri,
          signerIstance: correctVowDoSign.signerIstance,
          vcrId: correctVowDoSign.vcrId,
          certificateProfile: correctVowDoSign.certificateProfile,
        );

        expect(minDoSign.toJson(), minimalJson);

        final doSign2 = VowDoSign(
          storageUri: correctVowDoSign.storageUri,
          signerIstance: correctVowDoSign.signerIstance,
          vcrId: correctVowDoSign.vcrId,
          certificateProfile: correctVowDoSign.certificateProfile,
          sdnData: correctVowDoSign.sdnData,
        );

        expect(doSign2.toJson(), json2);
      });
    });
  });

  group('VowEncryptedData should have correct extension', () {
    test('Value should return the correct string representation', () {
      expect(
        VowEncryptedData.values.map((v) => v.value).toList()..sort(),
        [
          'content',
          'content_uri',
          'metadata.content_uri',
          'metadata.schema.uri',
        ]..sort(),
      );
    });

    test('fromValue() should return the correct enum', () {
      expect(
        VowEncryptedDataExt.fromValue('content'),
        VowEncryptedData.CONTENT,
      );

      expect(
        VowEncryptedDataExt.fromValue('content_uri'),
        VowEncryptedData.CONTENT_URI,
      );

      expect(
        VowEncryptedDataExt.fromValue('metadata.content_uri'),
        VowEncryptedData.METADATA_CONTENT_URI,
      );

      expect(
        VowEncryptedDataExt.fromValue('metadata.schema.uri'),
        VowEncryptedData.METADATA_SCHEMA_URI,
      );
    });
  });
}
