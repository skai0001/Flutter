import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflitedatabase/model/User.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "test.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, firstname TEXT, lastname TEXT,emailId TEXT )");
    print("Created tables");
  }

  void saveEmployee(User user) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO User(firstname, lastname, emailid ) VALUES(' +
              '\'' +
              user.firstName +
              '\'' +
              ',' +
              '\'' +
              user.lastName +
              '\'' +
              ',' +
              '\'' +
              user.emailId +
              '\'' +
              ')');
    });
  }

  Future<List<User>> getUsers() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM User');
    List<User> users = new List();
    for (int i = 0; i < list.length; i++) {
      users.add(new User(list[i]["firstname"], list[i]["lastname"], list[i]["emailid"]));
    }
    print(users.length);
    return users;
  }
}
