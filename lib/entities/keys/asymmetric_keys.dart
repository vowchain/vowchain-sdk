/// Represents a generic asymmetric private key
abstract class VowPrivateKey {}

/// Represents a generic asymmetric public key
abstract class VowPublicKey {
  Future<String> getEncoded();
  String getType();
}
