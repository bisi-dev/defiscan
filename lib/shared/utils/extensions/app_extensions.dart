import 'package:defiscan/core/app_core.dart';
import 'package:defiscan/shared/prefs/app_preferences.dart';
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

extension TimeDifferenceCalculator on DateTime {
  String format() {
    int elapsed =
        DateTime.now().millisecondsSinceEpoch - millisecondsSinceEpoch;

    String prefix = '';
    String suffix = 'ago'.i18n();

    final num seconds = elapsed / 1000;
    final num minutes = seconds / 60;
    final num hours = minutes / 60;
    final num days = hours / 24;
    final num months = days / 30;
    final num years = days / 365;

    String result;
    if (seconds < 45) {
      result = 'moment'.i18n();
    } else if (seconds < 90) {
      result = 'minute'.i18n();
    } else if (minutes < 45) {
      result = 'minutes'.i18n(['${minutes.round()}']);
    } else if (minutes < 90) {
      result = 'hour'.i18n();
    } else if (hours < 24) {
      result = 'hours'.i18n(['${hours.round()}']);
    } else if (hours < 48) {
      result = 'day'.i18n();
    } else if (days < 30) {
      result = 'days'.i18n(['$days']);
    } else if (days < 60) {
      result = 'month'.i18n();
    } else if (days < 365) {
      result = 'months'.i18n(['${months.round()}']);
    } else if (years < 2) {
      result = 'years'.i18n(['${years.round()}']);
    } else {
      result = '';
    }

    return [prefix, result, suffix].where((str) => str.isNotEmpty).join(' ');
  }
}

extension LengthRecorder on int {
  String record() {
    switch (this) {
      case 0:
        return 'empty'.i18n();
      case 1:
        return 'record'.i18n();
      default:
        return 'records'.i18n(['$this']);
    }
  }
}

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat('dd MMMM yyyy', AppPreferences.languageCode);
    return formatter.format(this);
  }
}
