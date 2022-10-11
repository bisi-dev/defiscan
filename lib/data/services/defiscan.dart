import 'package:ethers/ethers.dart';
import 'package:defiscan/core/app_core.dart';

class DeFiScan {
  Future<String> getCoinBalance(String balance, String crypto) async {
    try {
      List<String> selectedCurrency = await AppPreference.getCurrency();

      NetworkHelper networkHelper = NetworkHelper(
          'https://api.coingecko.com/api/v3/simple/price?ids=$crypto&vs_currencies=${selectedCurrency[1]}');

      var data = await networkHelper.getData();
      double rate = (data[crypto][selectedCurrency[1]]).toDouble();
      double doubleBalance = double.parse(balance);
      String fiatBalance = (doubleBalance * rate).toStringAsFixed(2);
      return '${selectedCurrency[0]} $fiatBalance';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getAccount(String rpc, String address) async {
    try {
      final provider = ethers.providers.jsonRpcProvider(url: rpc);
      final balance = await provider.getBalance(address);

      double goodBalance = double.parse(ethers.utils.formatEther(balance));
      return goodBalance.toStringAsFixed(4);
    } catch (e) {
      return 'Cannot access $rpc node';
    }
  }

  Future<dynamic> getAccountBalance(
      String baseURL, String address, String apiKey) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$baseURL?module=account&action=balance&address=$address&tag=latest&apikey=$apiKey');

    var data = await networkHelper.getData();
    return data ?? {"result": "Cannot find Balance"};
  }

  Future<dynamic> getAccountBTC(String address) async {
    NetworkHelper networkHelper =
        NetworkHelper('https://blockchain.info/balance?active=$address');

    var data = await networkHelper.getData();
    double goodBalance = data[address]['final_balance'] / 100000000;
    return goodBalance.toStringAsFixed(4);
  }

  Future<dynamic> getAccountTxnBTC(String address) async {
    NetworkHelper networkHelper =
        NetworkHelper('https://blockchain.info/rawaddr/$address');

    var data = await networkHelper.getData();
    return data['txs'];
  }

  Future<dynamic> getAccountTxn(String baseURL, String address,
      [String apiKey = 'YourApiKeyToken']) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$baseURL?module=account&action=txlist&address=$address&startblock=0&endblock=99999999&page=1&offset=10&sort=desc&apikey=$apiKey');

    var data = await networkHelper.getData();
    return data;
  }
}
