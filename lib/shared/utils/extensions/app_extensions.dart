import 'package:intl/intl.dart';

enum Crypto { btc, eth, ens }

extension CryptoIdentifier on String {
  Crypto? identifyCrypto() {
    RegExp btcRegExp = RegExp(r'([13]|bc1)[A-HJ-NP-Za-km-z1-9]{27,34}');
    RegExp ethRegExp = RegExp(r'^(0x)?[0-9A-Fa-f]{40}');

    if (btcRegExp.hasMatch(this)) return Crypto.btc;
    if (ethRegExp.hasMatch(this)) return Crypto.eth;
    if (contains('.eth')) return Crypto.ens;

    return null;
  }
}

extension CurrencyFormatter on String {
  String formatCurrency() {
    if (isEmpty) return "";
    double value = double.parse(this);

    final formatter = NumberFormat.simpleCurrency(locale: "en_Us");
    String newText = formatter.format(value);
    newText = newText.substring(1, newText.length);

    return newText;
  }
}
