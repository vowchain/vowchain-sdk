import 'package:sacco/sacco.dart';
import 'package:uuid/uuid.dart';
import 'package:vowchainsdk/export.dart';

Future<void> main() async {
  // --------------------------------------------
  // --- Setup network info
  // --------------------------------------------

  final lcdUrl = Uri.parse('http://localhost:1337');
  final networkInfo = NetworkInfo(
    bech32Hrp: 'did:vow:',
    lcdUrl: lcdUrl,
  );

  // --------------------------------------------
  // --- Creating a wallet for setIdentity
  // --------------------------------------------

  final mnemonic = Bip39.generateMnemonic(strength: 256).split(' ');
  final wallet = Wallet.derive(mnemonic, networkInfo);

  // --------------------------------------------
  // --- Creating setIdentity transaction
  // --------------------------------------------

  // Note that to set an identity and, in general, to perform operations on the
  // blockchain the [wallet] requires some tokens, for example given from the
  // tumbler or from another wallet.
  //
  // See https://docs.vowchain.net/developers/create-sign-broadcast-tx.html
  // to send tokens.

  final rsaVerificationKeyPair = await KeysHelper.generateRsaKeyPair(
    keyType: VowRSAKeyType.verification,
  );
  final rsaVerificationPubKey = rsaVerificationKeyPair.publicKey;

  final rsaSignatureKeyPair = await KeysHelper.generateRsaKeyPair(
    keyType: VowRSAKeyType.signature,
  );
  final rsaSignaturePubKey = rsaSignatureKeyPair.publicKey;

  try {
    final didDocument = await DidDocumentHelper.fromWallet(
      wallet: wallet,
      pubKeys: [rsaVerificationPubKey, rsaSignaturePubKey],
    );
    print('DDO:\n${didDocument.toJson()}');
    print('');

    final response = await IdHelper.setDidDocumentsList(
      [didDocument],
      wallet,
    );

    if (response.success) {
      print('TX successfully sent:\n$lcdUrl/txs/${response.hash}');
      print('----- You can retrive your did from below url -----');
      print('Endpoint:\n$lcdUrl/identities/${wallet.bech32Address}');
    } else {
      print('TX error:\n${response.error?.errorMessage}');
    }
  } catch (error) {
    print('Error while testing set DDO:\n$error');
  }

  // --------------------------------------------
  // --- Creating wallets for shareDocument
  // --------------------------------------------

  final senderMnemonic = Bip39.generateMnemonic(strength: 256).split(' ');
  final senderWallet = Wallet.derive(senderMnemonic, networkInfo);

  final recipientMnemonic = Bip39.generateMnemonic(strength: 256).split(' ');
  final recipientWallet = Wallet.derive(recipientMnemonic, networkInfo);

  // --------------------------------------------
  // --- Creating a shareDocument transaction
  // --------------------------------------------

  final docRecipientDid = recipientWallet.bech32Address;
  final docId = const Uuid().v4();

  final checksum = VowDocChecksum(
    value: 'a00ab326fc8a3dd93ec84f7e7773ac2499b381c4833e53110107f21c3b90509c',
    algorithm: VowDocChecksumAlgorithm.SHA256,
  );

  // Note that to perform a DoSign on the document that [senderWallet] would
  // share then the [recipientWallet] must have an identity on the blockchain.
  //
  // The steps needed to set an identity are described in
  // "Creating setIdentity transaction".
  //
  // See https://docs.vowchain.net/x/id/tx/create-an-identity.html

  final doSign = VowDoSign(
    storageUri: 'http://vowchain.net',
    signerIstance: 'did:vow:1cc65t29yuwuc32ep2h9uqhnwrregfq230lf2rj',
    sdnData: const {
      VowSdnData.COMMON_NAME,
      VowSdnData.SURNAME,
    },
    vcrId: 'xxxxx',
    certificateProfile: 'xxxxx',
  );

  try {
    final VowDoc = await VowDocHelper.fromWallet(
      wallet: senderWallet,
      recipients: [docRecipientDid],
      id: docId,
      metadata: VowDocMetadata(
        contentUri: 'https://example.com/document/metadata',
        schema: VowDocMetadataSchema(
          uri: 'https://example.com/custom/metadata/schema',
          version: '7.0.0',
        ),
      ),
      contentUri: 'https://example.com/document',
      checksum: checksum,
      doSign: doSign,
      encryptedData: {VowEncryptedData.CONTENT_URI},
    );
    final response = await DocsHelper.shareDocumentsList(
      [VowDoc],
      senderWallet,
    );

    if (response.success) {
      print('TX successfully sent:\n$lcdUrl/txs/${response.hash}');
      print('----- You can retrive your sent documents from url below -----');
      print('Endpoint:\n$lcdUrl/docs/${senderWallet.bech32Address}/sent');
    } else {
      print('TX error:\n${response.error?.errorMessage}');
    }
  } catch (error) {
    print('Error while sharing a document:\n$error');
  }
}
