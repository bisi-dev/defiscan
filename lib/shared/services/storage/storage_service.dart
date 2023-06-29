import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../features/explorer/models/account.dart';

class StorageService {
  static const String history = 'history';
  static const String watchlist = 'watchlist';
  static Box<Account> historyBox = Hive.box(history);
  static Box<Account> watchlistBox = Hive.box(watchlist);

  static Future<void> initLocalDatabase() async {
    if (!kIsWeb) {
      final appDocumentDirectory = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
    }

    Hive.registerAdapter(AccountAdapter());
    await Hive.openBox<Account>(history);
    await Hive.openBox<Account>(watchlist);
  }

  static Future<void> insertAccount(Account account, Box box) async {
    await deleteAccount(account, box);
    await box.put(account.id, account);
  }

  static Future<void> refreshWatchlist(Account account) async {
    final watchlist = watchlistBox.values.toList();
    if (watchlist.contains(account)) {
      insertAccount(account, watchlistBox);
    }
  }

  static Future<void> deleteAccount(Account account, Box box) async {
    await box.delete(account.id);
  }

  static Future<void> deleteAll(Box box) async {
    box.clear();
  }
}
