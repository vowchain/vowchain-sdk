import 'package:vowchainsdk/entities/mint/mint_ccc.dart';
import 'package:vowchainsdk/export.dart';

/// Represents the transaction message that must be used
/// to mint CCC
class MsgMintCcc extends StdMsg {
  final MintCcc mintCcc;

  MsgMintCcc({required this.mintCcc})
      : super(type: 'Vow/MsgMintCCC', value: <String, String>{});

  @override
  Map<String, dynamic> get value => mintCcc.toJson();
}
