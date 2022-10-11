import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import '../models/history.dart';

class LocalRepository {
  static void initLocalDatabase() async {
    await openDatabase(
      path.join(await getDatabasesPath(), 'history.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE allList(id INTEGER PRIMARY KEY, account TEXT, address TEXT, username TEXT, balance TEXT, timestamp TEXT)',
        );
        await db.execute(
          'CREATE TABLE watchList(id INTEGER PRIMARY KEY, account TEXT, address TEXT, username TEXT, balance TEXT, timestamp TEXT)',
        );
      },
    );
  }

  static Future<Database> localDatabase() async {
    Database database = await openDatabase(
      path.join(await getDatabasesPath(), 'history.db'),
    );
    return database;
  }

  static Future<List<History>> historyList() async {
    Database database = await localDatabase();

    List<Map> dbList = await database.rawQuery('SELECT * FROM allList');
    List<History> historyList = dbList
        .map(
          (obj) => History(
              id: obj['id'],
              account: obj['account'],
              address: obj['address'],
              username: obj['username'],
              balance: obj['balance'],
              timestamp: obj['timestamp']),
        )
        .toList();

    return historyList.reversed.toList();
  }

  static Future<List<History>> watchList() async {
    Database database = await localDatabase();

    List<Map> dbList = await database.rawQuery('SELECT * FROM watchList');
    List<History> watchList = dbList
        .map(
          (obj) => History(
              id: obj['id'],
              account: obj['account'],
              address: obj['address'],
              username: obj['username'],
              balance: obj['balance'],
              timestamp: obj['timestamp']),
        )
        .toList();

    return watchList.reversed.toList();
  }

  static void insertEntry(
      {required String account,
      required address,
      required username,
      required balance,
      required currency}) async {
    Database database = await localDatabase();
    try {
      await database
          .rawDelete('DELETE FROM allList WHERE address = "$address"');
      await database.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO allList(account, address, username, balance, timestamp) VALUES("$account", "$address", "$username", "$balance $currency", "${DateTime.now().toString()}" )');
      });
      int id = await database
          .rawDelete('DELETE FROM watchList WHERE address = "$address"');
      id > 0
          ? await database.transaction((txn) async {
              await txn.rawInsert(
                  'INSERT INTO watchList(account, address, username, balance, timestamp) VALUES("$account", "$address", "$username", "$balance $currency", "${DateTime.now().toString()}" )');
            })
          : id = 0;
    } catch (e) {
      return;
    }
  }

  static void removeEntry(
      {required String databaseName, required int id}) async {
    Database database = await localDatabase();
    await database.rawDelete('DELETE FROM $databaseName WHERE id = $id');
  }

  static void removeAll({required String databaseName}) async {
    Database database = await localDatabase();
    await database.rawDelete('DELETE FROM $databaseName');
  }

  static Future<String> addToWatchList(History history) async {
    Database database = await localDatabase();

    List<Map> dbList = await database.rawQuery(
        'SELECT * FROM watchList WHERE address = "${history.address}"');

    try {
      await database.rawDelete(
          'DELETE FROM watchList WHERE address = "${history.address}"');
    } catch (e) {
      return e.toString();
    }

    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO watchList(account, address, username, balance, timestamp) VALUES("${history.account}", "${history.address}", "${history.username}", "${history.balance}", "${history.timestamp}" )');
    });

    return dbList.isNotEmpty
        ? 'Already exists in Watchlist'
        : 'Added to Watchlist';
  }
}
