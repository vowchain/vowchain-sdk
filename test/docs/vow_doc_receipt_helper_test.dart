import 'package:vowchainsdk/export.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Functions of "VowDoReceiptHelper" class;', () {
    final networkInfo = NetworkInfo(
      bech32Hrp: 'did:vow:',
      lcdUrl: Uri.parse(''),
    );
    const mnemonicString =
        'dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology';
    final mnemonic = mnemonicString.split(' ');
    final wallet = Wallet.derive(mnemonic, networkInfo);

    final uuid = const Uuid().v4();
    const recipientDid = 'did:vow:14ttg3eyu88jda8udvxpwjl2pwxemh72w0grsau';
    const txHash = 'txHash';
    final documentId = const Uuid().v4();

    test('"fromWallet()" returns a well-formed "VowDocReceipt" object.', () {
      final expectedDocReceipt = VowDocReceipt(
        uuid: uuid,
        senderDid: wallet.bech32Address,
        recipientDid: recipientDid,
        txHash: txHash,
        documentUuid: documentId,
      );

      final vowDocReceipt = VowDocReceiptHelper.fromWallet(
        wallet: wallet,
        recipient: recipientDid,
        txHash: txHash,
        documentId: documentId,
      );

      expect(vowDocReceipt.uuid, isNot(expectedDocReceipt.uuid));
      expect(vowDocReceipt.senderDid, expectedDocReceipt.senderDid);
      expect(vowDocReceipt.recipientDid, expectedDocReceipt.recipientDid);
      expect(vowDocReceipt.txHash, expectedDocReceipt.txHash);
      expect(vowDocReceipt.documentUuid, expectedDocReceipt.documentUuid);
      expect(vowDocReceipt.proof, isNull);
    });

    test('Invalid sender bech32 format should throw an assertion error', () {
      expect(
        () => VowDocReceiptHelper.fromWallet(
          wallet: wallet,
          recipient: 'invalid bech32',
          txHash: txHash,
          documentId: documentId,
        ),
        throwsA(isA<AssertionError>()),
      );
    });

    test(
        'Invalid document uuid (not v4) format should throw an assertion error',
        () {
      expect(
        () => VowDocReceiptHelper.fromWallet(
          wallet: wallet,
          recipient: recipientDid,
          txHash: txHash,
          documentId: 'doc invalid uuid',
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
