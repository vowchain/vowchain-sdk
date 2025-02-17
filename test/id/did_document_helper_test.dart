import 'dart:convert';

import 'package:vowchainsdk/export.dart';
import 'package:pointycastle/export.dart';
import 'package:sacco/sacco.dart';
import 'package:test/test.dart';

void main() async {
  final networkInfo = NetworkInfo(
    bech32Hrp: 'did:vow:',
    lcdUrl: Uri.parse(''),
  );
  const mnemonicString =
      'dash ordinary anxiety zone slot rail flavor tortoise guilt divert pet '
      'sound ostrich increase resist short ship lift town ice split payment round apology';
  final mnemonic = mnemonicString.split(' ');
  final wallet = Wallet.derive(mnemonic, networkInfo);

  final modulusVerification = BigInt.from(125);
  final exponentVerification = BigInt.from(126);
  final rsaPubKeyVerification = VowRSAPublicKey(
    RSAPublicKey(
      modulusVerification,
      exponentVerification,
    ),
    keyType: VowRSAKeyType.verification,
  );

  final encodedPubKeyPem = await rsaPubKeyVerification.getEncoded();
  final verificationPubKey = DidDocumentPublicKey(
    id: '${wallet.bech32Address}#keys-1',
    type: 'RsaVerificationKey2018',
    controller: wallet.bech32Address,
    publicKeyPem: encodedPubKeyPem,
  );

  final modulusSignature = BigInt.from(135);
  final exponentSignature = BigInt.from(136);
  final rsaPubKeySignature = VowRSAPublicKey(
    RSAPublicKey(
      modulusSignature,
      exponentSignature,
    ),
    keyType: VowRSAKeyType.signature,
  );

  final signaturePubKeyEncodedPubKeyPem = await rsaPubKeySignature.getEncoded();
  final signaturePubKey = DidDocumentPublicKey(
    id: '${wallet.bech32Address}#keys-2',
    type: 'RsaSignatureKey2018',
    controller: wallet.bech32Address,
    publicKeyPem: signaturePubKeyEncodedPubKeyPem,
  );

  final proofSignatureContent = DidDocumentProofSignatureContent(
    context: 'https://www.w3.org/ns/did/v1',
    id: wallet.bech32Address,
    publicKeys: [verificationPubKey, signaturePubKey],
  );

  final expectedComputedProof = DidDocumentProof(
    type: 'EcdsaSecp256k1VerificationKey2019',
    timestamp: getTimeStamp(),
    proofPurpose: 'authentication',
    controller: wallet.bech32Address,
    verificationMethod: wallet.bech32PublicKey,
    signatureValue: base64.encode(
      SignHelper.signSorted(proofSignatureContent.toJson(), wallet),
    ),
  );

  final expectedDidDocument = DidDocument(
    context: 'https://www.w3.org/ns/did/v1',
    id: wallet.bech32Address,
    publicKeys: [verificationPubKey, signaturePubKey],
    proof: expectedComputedProof,
    service: const [],
  );

  test(
      'fromWallet return a well-formed, ready to be send to blockchain, did document',
      () async {
    final didDocument = await DidDocumentHelper.fromWallet(
      wallet: wallet,
      pubKeys: [
        rsaPubKeyVerification,
        rsaPubKeySignature,
      ],
    );

    expect(didDocument.context, expectedDidDocument.context);
    expect(didDocument.id, expectedDidDocument.id);

    for (var i = 0; i < expectedDidDocument.publicKeys.length; i++) {
      expect(didDocument.publicKeys[i], expectedDidDocument.publicKeys[i]);
    }

    expect(didDocument.proof.type, expectedDidDocument.proof.type);
    expect(
        didDocument.proof.proofPurpose, expectedDidDocument.proof.proofPurpose);
    expect(didDocument.proof.controller, expectedDidDocument.proof.controller);
    expect(didDocument.proof.verificationMethod,
        expectedDidDocument.proof.verificationMethod);
    expect(didDocument.proof.timestamp, isNot(expectedComputedProof.timestamp));
    // The difference depends on the "secureRandom" method used at the time of the signature.
    expect(didDocument.proof.signatureValue,
        isNot(expectedDidDocument.proof.signatureValue));
    expect(didDocument.proof.signatureValue.length,
        expectedDidDocument.proof.signatureValue.length);
  });
}
