import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/material_model.dart';

class DbHelperMaterial {
  static Future getDb() async {
    return openDatabase(join(await getDatabasesPath(), 'Matials.db'),
        onCreate: (db, version) {
      db.execute('CREATE TABLE matials(name TEXT, price TEXT)');
    }, version: 1);
  }

  static Future<void> addUser(MaterialModel materialModel) async {
    final db = await getDb();
    await db.insert(
      'matials',
      materialModel.objToMap(),
    );
  }

  static Future<void> deleteUser(MaterialModel materialModel) async {
    final db = await getDb();
    await db
        .delete('matials', where: 'name=?', whereArgs: [materialModel.name]);
  }

  static Future<List<MaterialModel>?> getAllUsers() async {
    final db = await getDb();
    final List<Map<String, dynamic>> maps = await db.query('matials');
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
      maps.length,
      (index) {
        return MaterialModel.mapToObj(maps[index]);
      },
    );
  }
}
