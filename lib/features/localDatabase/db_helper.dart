import 'dart:convert';

import 'package:book_im/features/localDatabase/LocalLocator.dart';
import 'package:book_im/features/localDatabase/localBook.dart';
import 'package:book_im/features/localDatabase/local_db_keys.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper != null) {
      return _databaseHelper;
    } else {
      _databaseHelper = DatabaseHelper._createObject();
      return _databaseHelper;
    }
  }

  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "book_im.db";
    Database bookImDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return bookImDb;
  }

  _createDb(Database db, int newVersion) async {
    await createTables(db);
  }

  createTables(Database db) async {
    await db.execute(
        "CREATE TABLE ${TableKeys.tableBook} (${TableKeys.bookId} TEXT PRIMARY KEY ,"
        "${TableKeys.bookPath} TEXT ,${TableKeys.bookImage} TEXT,${TableKeys.bookSize} TEXT,"
        "${TableKeys.bookName} TEXT)");
    await db.execute(
        "CREATE TABLE ${TableKeys.tableLocators} (${TableKeys.locatorId} TEXT PRIMARY KEY ,${TableKeys.locatorData} TEXT)");
  }

  clearAllTables() {}

  clearAllLocalData() async {}

  //book table fucnctions
  Future<int> addBook(LocalBook company) async {
    Database db = await this.database;
    int result = await db.insert(TableKeys.tableBook, company.toJson());
    print("resutl of adding Doc $result");
    return result;
  }

  Future<int> removeBook(LocalBook company) async {
    Database db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM ${TableKeys.tableBook} WHERE ${TableKeys.bookId} = ?',
        ['${company.id}']);
    return result;
  }

  Future<LocalBook> getBookById(String id) async {
    LocalBook item;
    print('fetch id ${id}');
    Database db = await this.database;
    List jsonList = await db.query(TableKeys.tableBook,
        where: '${TableKeys.bookId} = ?', whereArgs: ['${id}']);
    print("got ${jsonList}");
    if (jsonList.isNotEmpty) {
      item = LocalBook.fromJson(jsonList[0]);
    }

    return item;
  }

  Future<List<LocalBook>> getBookList() async {
    print("fetching doc ");
    Database db = await this.database;
    List<LocalBook> companyList = List<LocalBook>();
    List jsonList = await db.query('${TableKeys.tableBook}');
    for (Map map in jsonList) {
      await companyList.add(LocalBook.fromJson(map));
    }
    return companyList;
  }

  Future<int> removeAllBooks() async {
    Database db = await this.database;
    int result = await db.delete("${TableKeys.tableBook}");
    print("result of removing all book $result");
    return result;
  }

  //Locator table fucnctions
  Future<int> addLocator(LocalLocator localLocator) async {
    Database db = await this.database;
    int result =
        await db.insert(TableKeys.tableLocators, localLocator.toJson());
    print("resutl of adding locator $result");
    return result;
  }

  Future<int> updateLocator(LocalLocator localLocator) async {
    print("update locator");
    Database db = await this.database;
    int result =
        await db.update(TableKeys.tableLocators, localLocator.toJson());
print("result of updating ${result}");
    return result;
  }

  Future<int> removeLocator(String bookId) async {
    Database db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM ${TableKeys.tableLocators} WHERE ${TableKeys.locatorId} = ?',
        ['${bookId}']);
    return result;
  }

  Future<LocalLocator> getLocatorById(String id) async {
    LocalLocator item;
    Database db = await this.database;
    List jsonList = await db.query(TableKeys.tableLocators,
        where: '${TableKeys.locatorId} = ?', whereArgs: ['${id}']);
    if (jsonList.isNotEmpty) {
      item = LocalLocator.fromJson(jsonList[0]);
    }

    return item;
  }

  Future<List<LocalLocator>> getLocatorList() async {
    print("fetching doc ");
    Database db = await this.database;
    List<LocalLocator> locatorList = List<LocalLocator>();
    List jsonList = await db.query('${TableKeys.tableLocators}');
    for (Map map in jsonList) {
      await locatorList.add(LocalLocator.fromJson(map));
    }
    return locatorList;
  }

  Future<int> removeAllLocator() async {
    Database db = await this.database;
    int result = await db.delete("${TableKeys.tableLocators}");
    print("result of removing all book $result");
    return result;
  }
}
