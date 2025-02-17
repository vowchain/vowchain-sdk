import 'package:vowchainsdk/export.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pointycastle/export.dart';

part 'did_document.g.dart';

/// Vow network's did document is described here:
/// https://scw-gitlab.zotsell.com/Vow Chain/Cosmos-application/blob/master/Vow%20Decentralized%20ID%20framework.md
@JsonSerializable(explicitToJson: true)
class DidDocument extends Equatable {
  @JsonKey(name: '@context')
  final String context;

  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'publicKey')
  final List<DidDocumentPublicKey?> publicKeys;

  @JsonKey(name: 'proof')
  final DidDocumentProof proof;

  @JsonKey(name: 'service', includeIfNull: false)
  final List<DidDocumentService>? service;

  const DidDocument({
    required this.context,
    required this.id,
    required this.publicKeys,
    required this.proof,
    this.service,
  });

  @override
  List<Object?> get props {
    return [context, id, publicKeys, proof, service];
  }

  /// Returns the [PublicKey] that should be used as the public encryption
  /// key when encrypting data that can later be read only by the owner of
  /// this Did Document.
  VowRSAPublicKey? get encryptionKey {
    final pubKey = publicKeys.firstWhere(
      (key) => key?.type == VowRSAKeyType.verification.value,
      orElse: () => null,
    );

    if (pubKey == null) {
      return null;
    }

    return VowRSAPublicKey(
      RSAKeyParser.parseFromPem(pubKey.publicKeyPem) as RSAPublicKey,
      keyType: VowRSAKeyType.verification,
    );
  }

  factory DidDocument.fromJson(Map<String, dynamic> json) =>
      _$DidDocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DidDocumentToJson(this);
}
