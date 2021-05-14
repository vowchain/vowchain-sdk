import 'package:vowchainsdk/entities/keys/asymmetric_keys.dart';

///An asymmetric pair of public and private asymmetric keys
class VowKeyPair<P extends VowPublicKey, S extends VowPrivateKey> {
  final P publicKey;
  final S privateKey;

  VowKeyPair(this.publicKey, this.privateKey);
}
