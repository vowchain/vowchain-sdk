import 'package:vowchainsdk/export.dart';
import 'package:http/http.dart' as http;

/// Allows to easily create a VowDoc and perform common related operations
class VowDocHelper {
  /// Creates a VowDoc from the given [wallet],
  /// [recipients], [id], [metadata]
  /// and optionally [contentUri], [checksum],
  /// [doSign], [encryptedData], [aesKey].
  static Future<VowDoc> fromWallet({
    required Wallet wallet,
    required List<String> recipients,
    required String id,
    required VowDocMetadata metadata,
    String? contentUri,
    VowDocChecksum? checksum,
    VowDoSign? doSign,
    Set<VowEncryptedData>? encryptedData,
    Uint8List? aesKey,
    http.Client? client,
  }) async {
    // Build a Vow document
    var VowDocument = VowDoc(
      senderDid: wallet.bech32Address,
      recipientDids: recipients,
      uuid: id,
      contentUri: contentUri,
      metadata: metadata,
      checksum: checksum,
      doSign: doSign,
    );

    // Encrypt its contents, if necessary
    if (encryptedData != null && encryptedData.isNotEmpty) {
      // Get a default aes key for encryption if needed
      final key = aesKey ?? await KeysHelper.generateAesKey();

      VowDocument = await encryptField(
        VowDocument,
        key,
        encryptedData,
        recipients,
        wallet,
        client: client,
      );
    }

    return VowDocument;
  }
}
