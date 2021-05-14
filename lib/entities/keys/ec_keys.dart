import 'dart:convert';

import 'package:vowchainsdk/entities/export.dart';
import 'package:pointycastle/export.dart' as pointy_castle;

/// Wrapper of the pointyCastle ECPublicKey
class VowECPublicKey implements VowPublicKey {
  final pointy_castle.ECPublicKey pubKey;
  final String? keyType;

  VowECPublicKey(
    this.pubKey, {
    this.keyType,
  });

  @override
  String getType() => keyType ?? 'Secp256k1VerificationKey2018';

  @override
  Future<String> getEncoded() async {
    return base64.encode(pubKey.Q!.getEncoded(false));
  }
}

/// Wrapper of the pointyCastle ECPrivateKey
class VowECPrivateKey implements VowPrivateKey {
  final pointy_castle.ECPrivateKey secretKey;

  VowECPrivateKey(this.secretKey);
}
