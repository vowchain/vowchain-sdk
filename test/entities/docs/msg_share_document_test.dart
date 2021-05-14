import 'package:vowchainsdk/entities/docs/export.dart';
import 'package:test/test.dart';

void main() {
  final correctVowDoc = VowDoc(
    senderDid: 'did:vow:1acdefg',
    recipientDids: const ['did:vow:1acdefg'],
    uuid: 'c510755c-c27d-4348-bf4c-f6050fc6935c',
    metadata: VowDocMetadata(
      contentUri: 'content-uri',
      schemaType: 'schemaType',
      schema: VowDocMetadataSchema(
        uri: 'http://uri.url',
        version: '1',
      ),
    ),
    contentUri: 'content-uri',
    checksum: VowDocChecksum(
      value: 'value',
      algorithm: VowDocChecksumAlgorithm.MD5,
    ),
    doSign: VowDoSign(
      storageUri: 'http://do.sign',
      signerIstance: 'signer',
      vcrId: 'vcrId',
      certificateProfile: 'profile',
      sdnData: const {VowSdnData.COMMON_NAME},
    ),
    encryptionData: VowDocEncryptionData(
      keys: [
        VowDocEncryptionDataKey(
          recipientDid: 'did:vow:1acdefg',
          value: 'value',
        ),
      ],
      encryptedData: const {VowEncryptedData.CONTENT_URI},
    ),
  );
  final correctMsgShareDoc = MsgShareDocument(document: correctVowDoc);

  test('Type should be "Vow/MsgShareDocument"', () {
    expect(
      correctMsgShareDoc.type,
      'Vow/MsgShareDocument',
    );
  });

  test('Value should the VowDoc json', () {
    expect(
      correctMsgShareDoc.value,
      correctVowDoc.toJson(),
    );
  });
}
