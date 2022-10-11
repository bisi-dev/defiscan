import 'package:defiscan/core/app_core.dart';
import 'package:defiscan/data/app_data.dart';

import 'package:ens_dart/ens_dart.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:defiscan/data/services/defiscan.dart';

class RemoteRepository extends ChangeNotifier {
  String entry = '';
  String info = 'Start By Searching...';
  List<Account> accountList = [];
  RemoteState? remoteState = RemoteState.empty;
  DeFiScan deFiScan = DeFiScan();

  RemoteRepository();

  getAccountsList() async {
    final client = Web3Client(AppURL.mainnetRPC, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(AppURL.wsRPC).cast<String>();
    });
    final ens = Ens(client: client);

    accountList.clear();
    remoteState = RemoteState.loading;
    info = 'Searching...';
    notifyListeners();

    entry = entry.trim();

    //null
    if (entry.isEmpty) {
      reset();
      return;
    }

    // bitcoin
    if (entry.startsWith('1') ||
        entry.startsWith('3') ||
        entry.startsWith('bc1')) {
      String accountBTC = await deFiScan.getAccountBTC(entry);
      String fiatBTC = await deFiScan.getCoinBalance(accountBTC, 'bitcoin');
      String user = 'Anonymous';

      // 1KoG15hRKk4Ley15tYYmEA9frRN5XqoGFw
      info = 'BTC Account Found';
      accountList.add(Account("Bitcoin", '$accountBTC BTC', fiatBTC, entry,
          user, AppImage.bitcoinImage));

      remoteState = null;

      LocalRepository.insertEntry(
          account: "Bitcoin",
          address: entry,
          username: user,
          balance: accountBTC,
          currency: "BTC");
      notifyListeners();
      return;
    }

    //ens
    if (entry.contains('.eth')) {
      String address = (await ens.withName(entry).getAddress()).toString();

      if (address == '0x0000000000000000000000000000000000000000') {
        info = 'NO ENS Record';

        remoteState = null;
        notifyListeners();
        return;
      }

      String accountMain =
          await deFiScan.getAccount(AppURL.mainnetRPC, address);
      String accountPolygon =
          await deFiScan.getAccount(AppURL.polygonRPC, address);
      String accountRopsten =
          await deFiScan.getAccount(AppURL.ropstenRPC, address);
      String accountRinkeby =
          await deFiScan.getAccount(AppURL.rinkebyRPC, address);
      String accountGoerli =
          await deFiScan.getAccount(AppURL.goerliRPC, address);
      String accountKovan = await deFiScan.getAccount(AppURL.kovanRPC, address);
      //vitalik.eth

      String fiatMain = await deFiScan.getCoinBalance(accountMain, 'ethereum');
      String fiatPolygon =
          await deFiScan.getCoinBalance(accountPolygon, 'matic-network');
      String fiatRopsten =
          await deFiScan.getCoinBalance(accountRopsten, 'ethereum');
      String fiatRinkeby =
          await deFiScan.getCoinBalance(accountRinkeby, 'ethereum');
      String fiatGoerli =
          await deFiScan.getCoinBalance(accountGoerli, 'ethereum');
      String fiatKovan =
          await deFiScan.getCoinBalance(accountKovan, 'ethereum');

      info = 'ETH Account Found';
      accountList.add(Account("Ethereum Mainnet", '$accountMain ETH', fiatMain,
          address, entry, AppImage.ethereumImage));
      accountList
          .add(Account("Polygon", '$accountPolygon MATIC', fiatPolygon, entry));
      accountList
          .add(Account("Ropsten", '$accountRopsten ETH', fiatRopsten, entry));
      accountList
          .add(Account("Rinkeby", '$accountRinkeby ETH', fiatRinkeby, entry));
      accountList
          .add(Account("Goerli", '$accountGoerli ETH', fiatGoerli, entry));
      accountList.add(Account("Kovan", '$accountKovan ETH', fiatKovan, entry));

      LocalRepository.insertEntry(
          account: "Ethereum Mainnet",
          address: address,
          username: entry,
          balance: accountMain,
          currency: "ETH");

      remoteState = null;
      notifyListeners();
      return;
    }

    // ethereum
    if (entry.startsWith('0x')) {
      String user = 'Anonymous';

      try {
        final username = await ens.withAddress(entry).getName();
        user = username;
      } catch (e) {
        return;
      }

      String accountMain = await deFiScan.getAccount(AppURL.mainnetRPC, entry);
      String accountPolygon =
          await deFiScan.getAccount(AppURL.polygonRPC, entry);
      String accountRopsten =
          await deFiScan.getAccount(AppURL.ropstenRPC, entry);
      String accountRinkeby =
          await deFiScan.getAccount(AppURL.rinkebyRPC, entry);
      String accountGoerli = await deFiScan.getAccount(AppURL.goerliRPC, entry);
      String accountKovan = await deFiScan.getAccount(AppURL.kovanRPC, entry);

      String fiatMain = await deFiScan.getCoinBalance(accountMain, 'ethereum');
      String fiatPolygon =
          await deFiScan.getCoinBalance(accountPolygon, 'matic-network');
      String fiatRopsten =
          await deFiScan.getCoinBalance(accountRopsten, 'ethereum');
      String fiatRinkeby =
          await deFiScan.getCoinBalance(accountRinkeby, 'ethereum');
      String fiatGoerli =
          await deFiScan.getCoinBalance(accountGoerli, 'ethereum');
      String fiatKovan =
          await deFiScan.getCoinBalance(accountKovan, 'ethereum');

      info = 'ETH Account Found';

      accountList.add(Account("Ethereum Mainnet", '$accountMain ETH', fiatMain,
          entry, user, AppImage.ethereumImage));
      accountList
          .add(Account("Polygon", '$accountPolygon MATIC', fiatPolygon, entry));
      accountList
          .add(Account("Ropsten", '$accountRopsten ETH', fiatRopsten, entry));
      accountList
          .add(Account("Rinkeby", '$accountRinkeby ETH', fiatRinkeby, entry));
      accountList
          .add(Account("Goerli", '$accountGoerli ETH', fiatGoerli, entry));
      accountList.add(Account("Kovan", '$accountKovan ETH', fiatKovan, entry));

      LocalRepository.insertEntry(
          account: "Ethereum Mainnet",
          address: entry,
          username: user,
          balance: accountMain,
          currency: "ETH");
      remoteState = null;
      notifyListeners();
      return;
    }

    remoteState = RemoteState.error;
    info = 'Error: Invalid Address';
    notifyListeners();
  }

  void paste() async {
    var data = await Clipboard.getData('text/plain');
    if (data == null) {
      data = await Clipboard.getData('text/html');
      entry = (data?.text?.toString()).toString();
    } else {
      entry = (data.text.toString()).toString();
    }
    notifyListeners();
  }

  reset() {
    entry = '';
    info = 'Start By Searching...';
    accountList = [];
    remoteState = RemoteState.empty;
    notifyListeners();
  }
}
