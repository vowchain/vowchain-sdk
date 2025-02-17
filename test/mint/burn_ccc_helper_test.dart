import 'package:vowchainsdk/export.dart';
import 'package:vowchainsdk/mint/export.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Functions of "BurnCccHelper" class', () {
    final networkInfo = NetworkInfo(
      bech32Hrp: 'did:vow:',
      lcdUrl: Uri.parse(''),
    );
    const mnemonicString =
        'dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet sound ostrich increase resist short ship lift town ice split payment round apology';
    final mnemonic = mnemonicString.split(' ');
    final wallet = Wallet.derive(mnemonic, networkInfo);

    test('if "fromwallet()" returns a well-formed "BurnCcc" object', () {
      const amount = StdCoin(denom: 'uccc', amount: '10');
      final id = const Uuid().v4();

      final expectedBurnCcc = BurnCcc(
        signerDid: wallet.bech32Address,
        amount: amount,
        id: id,
      );

      final burnCcc = BurnCccHelper.fromWallet(
        amount: amount,
        id: id,
        wallet: wallet,
      );

      expect(
        burnCcc.toJson(),
        expectedBurnCcc.toJson(),
      );
    });
  });
}
