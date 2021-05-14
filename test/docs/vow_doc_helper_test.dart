import 'dart:io';

import 'package:vowchainsdk/export.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Functions of "VowDocHelper" class;', () {
    final networkInfo = NetworkInfo(
      bech32Hrp: 'did:vow:',
      lcdUrl: Uri.parse(''),
    );
    const mnemonicString =
        'dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology';
    final mnemonic = mnemonicString.split(' ');
    final wallet = Wallet.derive(mnemonic, networkInfo);
    final senderDid = wallet.bech32Address;
    final recipientDids = ['did:vow:1acdefg', 'did:vow:1acdefg'];
    const recipientWithDDO = 'did:vow:1fswhnd44fv2qk7ls4gflxh7spu7xpqdue54s3m';
    final uuid = const Uuid().v4();
    final metadata = VowDocMetadata(
      contentUri: 'https://example.com/document/metadata',
      schema: VowDocMetadataSchema(
        uri: 'https://example.com/custom/metadata/schema',
        version: '7.0.0',
      ),
    );
    final getWalletIdentityResponse =
        File('test_resources/get_wallet_identity_response.json')
            .readAsStringSync();

    test('"fromWallet()" returns a well-formed "VowDoc" object.', () async {
      final mockClient =
          MockClient((req) async => Response(getWalletIdentityResponse, 200));

      final expectedVowDoc = VowDoc(
        senderDid: senderDid,
        recipientDids: const [recipientWithDDO],
        uuid: uuid,
        metadata: metadata,
      );

      final vowDoc = await VowDocHelper.fromWallet(
        wallet: wallet,
        recipients: const [recipientWithDDO],
        id: uuid,
        metadata: metadata,
      );

      expect(vowDoc.toJson(), expectedVowDoc.toJson());

      final VowDocWithEncryptedData = await VowDocHelper.fromWallet(
        wallet: wallet,
        recipients: const [recipientWithDDO],
        id: uuid,
        metadata: metadata,
        contentUri: 'contentUri',
        encryptedData: {VowEncryptedData.CONTENT_URI},
        client: mockClient,
      );

      expect(
        VowDocWithEncryptedData.contentUri != expectedVowDoc.contentUri,
        isTrue,
      );
    });

    test(
        'fromWallet() should throw a WalletIdentityNotFoundException if any of the recipients does not have a DDO',
        () {
      final mockClientEveryoneNotFound =
          MockClient((req) async => Response('', 404));

      expect(
        () => VowDocHelper.fromWallet(
          wallet: wallet,
          recipients: recipientDids,
          id: uuid,
          metadata: metadata,
          contentUri: 'contentUri',
          encryptedData: {VowEncryptedData.CONTENT_URI},
          client: mockClientEveryoneNotFound,
        ),
        throwsA(isA<WalletIdentityNotFoundException>()),
      );

      final mockClientOnyOneNotFound = MockClient((req) async {
        if (req.url.path.contains(recipientDids.last)) {
          Response(getWalletIdentityResponse, 200);
        }

        return Response('', 404);
      });

      expect(
        () => VowDocHelper.fromWallet(
          wallet: wallet,
          recipients: recipientDids,
          id: uuid,
          metadata: metadata,
          contentUri: 'contentUri',
          encryptedData: {VowEncryptedData.CONTENT_URI},
          client: mockClientOnyOneNotFound,
        ),
        throwsA(isA<WalletIdentityNotFoundException>()),
      );
    });

    test(
        'fromWallet() should throw an ArgumentError if passing CONTENT_URI with null contentUri param',
        () async {
      expect(
        () => VowDocHelper.fromWallet(
          wallet: wallet,
          recipients: recipientDids,
          id: uuid,
          metadata: metadata,
          encryptedData: {VowEncryptedData.CONTENT_URI},
        ),
        throwsArgumentError,
      );
    });

    test(
        'fromWallet() should throw an ArgumentError if passing METADATA_SCHEMA_URI with null metadata.schema param',
        () async {
      expect(
        () => VowDocHelper.fromWallet(
          wallet: wallet,
          recipients: recipientDids,
          id: uuid,
          metadata: VowDocMetadata(
            contentUri: 'contentUri',
            schema: null,
            schemaType: 'schemaType',
          ),
          encryptedData: {VowEncryptedData.METADATA_SCHEMA_URI},
        ),
        throwsArgumentError,
      );
    });
  });
}
