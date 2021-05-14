import 'package:vowchainsdk/export.dart';
import 'package:uuid/uuid.dart';

/// Allows to easily create a [VowDocReceipt] and perform common related
/// operations.
class VowDocReceiptHelper {
  /// Build a `VowDocReceipt` from the given [wallet], [recipient],
  /// [txHash], [documentId] and an optional [proof].
  ///
  /// The [txHash] is the transaction in the blockchain that contains the
  /// [VowDoc] that you want to generate a recepit for. You can get the
  /// [recipient], that is, the [VowDoc] sender and the [documentId] from
  /// the transaction data.
  ///
  /// The [proof] should be some kind of agreeded method between the
  /// [VowDoc] sender and receivers that the documen has been read.
  static VowDocReceipt fromWallet({
    required Wallet wallet,
    required String recipient,
    required String txHash,
    required String documentId,
    String? proof,
  }) {
    return VowDocReceipt(
      uuid: const Uuid().v4(),
      senderDid: wallet.bech32Address,
      recipientDid: recipient,
      txHash: txHash,
      documentUuid: documentId,
      proof: proof,
    );
  }
}
