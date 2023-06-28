import 'package:dartz/dartz.dart';
import 'package:defiscan/shared/prefs/app_preferences.dart';
import 'package:defiscan/shared/services/network/app_network.dart';
import 'package:ens_dart/ens_dart.dart';
import 'package:ethers/ethers.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

abstract class ExplorerRepository {
  Future<Either<ErrorResponse, int>> getBalanceBTC(String address);
  Future<double> getCoinRate(String crypto);
  Future<String> getETHAddress(String entry);
  Future<String> getETHUsername(String address);
  Future<double> getBalanceETH(String address, String rpc);
}

class ExplorerRepositoryImpl extends ExplorerRepository {
  @override
  Future<Either<ErrorResponse, int>> getBalanceBTC(String address) async {
    try {
      final response = await NetworkService.get(
          url: '${NetworkConstants.blockChainInfo}?active=$address');

      int balance = response[address]['final_balance'];
      return (Right(balance));
    } catch (e) {
      return Left(ErrorResponse.fromJson(e));
    }
  }

  @override
  Future<double> getCoinRate(String crypto) async {
    String currencyCode = AppPreferences.currencyCode;
    try {
      final response = await NetworkService.get(
          url:
              '${NetworkConstants.balanceInfo}?ids=$crypto&vs_currencies=$currencyCode');

      return response[crypto][currencyCode] / 1;
    } catch (e) {
      return 0.00;
    }
  }

  @override
  Future<String> getETHAddress(String entry) async {
    final client =
        Web3Client(NetworkConstants.mainnetRPC, NetworkService.client,
            socketConnector: () {
      return IOWebSocketChannel.connect(NetworkConstants.wsRPC).cast<String>();
    });
    final ens = Ens(client: client);

    String address = (await ens.withName(entry).getAddress()).hex;
    if (address == '0x0000000000000000000000000000000000000000') address = '';
    return address;
  }

  @override
  Future<String> getETHUsername(String address) async {
    final client =
        Web3Client(NetworkConstants.mainnetRPC, NetworkService.client,
            socketConnector: () {
      return IOWebSocketChannel.connect(NetworkConstants.wsRPC).cast<String>();
    });
    final ens = Ens(client: client);

    try {
      final username = await ens.withAddress(address).getName();
      return username;
    } catch (e) {
      return 'Anonymous';
    }
  }

  @override
  Future<double> getBalanceETH(String address, String rpc) async {
    try {
      final provider = ethers.providers.jsonRpcProvider(url: rpc);
      final balance = await provider.getBalance(address);

      return double.parse(ethers.utils.formatEther(balance));
    } catch (e) {
      return 0.00;
    }
  }
}
