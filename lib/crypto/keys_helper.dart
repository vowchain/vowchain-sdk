import 'dart:math';
import 'dart:typed_data';

import 'package:vowchainsdk/export.dart';
import 'package:pointycastle/export.dart';

/// Allows to easily generate new keys either to be used with AES or RSA key.
class KeysHelper {
  /// Generates a SecureRandom
  static SecureRandom _getSecureRandom() {
    final secureRandom = FortunaRandom();
    final random = Random.secure();
    final seed = List<int>.generate(32, (_) => random.nextInt(256));
    secureRandom.seed(KeyParameter(Uint8List.fromList(seed)));
    return secureRandom;
  }

  /// Generate a random nonce
  static Uint8List generateRandomNonce(int length, {int bit = 256}) {
    final random = Random.secure();
    final nonce = List<int>.generate(length, (_) => random.nextInt(bit));
    return Uint8List.fromList(nonce);
  }

  /// Generates a new AES key having the desired [length].
  static Future<Uint8List> generateAesKey({int length = 256}) async {
    return generateRandomNonce(length ~/ 16);
  }

  /// Generates a new RSA key pair having the given [bytes] length.
  /// If no length is specified, the default is going to be 2048.
  static Future<VowKeyPair<VowRSAPublicKey, VowRSAPrivateKey>>
      generateRsaKeyPair({
    required VowRSAKeyType keyType,
    int bytes = 2048,
  }) async {
    final rsa = RSAKeyGeneratorParameters(BigInt.from(65537), bytes, 5);
    final params = ParametersWithRandom(rsa, _getSecureRandom());
    final keyGenerator = RSAKeyGenerator();
    keyGenerator.init(params);
    final keyPair = keyGenerator.generateKeyPair();

    return VowKeyPair(
      VowRSAPublicKey(
        keyPair.publicKey as RSAPublicKey,
        keyType: keyType,
      ),
      VowRSAPrivateKey(keyPair.privateKey as RSAPrivateKey),
    );
  }

  /// Generates a new random EC key pair.
  static Future<VowKeyPair<VowECPublicKey, VowECPrivateKey>> generateEcKeyPair(
      {String? type}) async {
    final keyParams = ECKeyGeneratorParameters(ECCurve_secp256k1());
    final generator = ECKeyGenerator();
    generator.init(ParametersWithRandom(keyParams, _getSecureRandom()));
    final keyPair = generator.generateKeyPair();
    return VowKeyPair(
      VowECPublicKey(keyPair.publicKey as ECPublicKey, keyType: type),
      VowECPrivateKey(keyPair.privateKey as ECPrivateKey),
    );
  }
}
