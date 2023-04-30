import 'package:flutter_application_12/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelperUser {
  static Future getDb() async {
    return openDatabase(join(await getDatabasesPath(), 'Users.db'),
        onCreate: (db, version) {
      db.execute('CREATE TABLE users(name TEXT,password TEXT)');
    }, version: 1);
  }

  static Future<void> addUser(UserModel userModel) async {
    final db = await getDb();
    await db.insert(
      'users',
      userModel.objToMap(),
    );
  }

  static Future<void> updateUser(UserModel userModel) async {
    final db = await getDb();
    await db.rawQuery(
        "UPDATE users SET password = '${userModel.password}' WHERE name = '${userModel.name}'");
  }
}
