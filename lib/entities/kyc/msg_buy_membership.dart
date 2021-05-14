import 'package:vowchainsdk/export.dart';

/// Represents the transaction message that must be used when wanting to buy a membership.
class MsgBuyMembership extends StdMsg {
  final BuyMembership buyMembership;

  MsgBuyMembership({
    required this.buyMembership,
  }) : super(type: 'Vow/MsgBuyMembership', value: <String, String>{});

  @override
  Map<String, dynamic> get value => buyMembership.toJson();
}
