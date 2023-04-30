import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/labour_model.dart';

class DbHelperLabour {
  static Future getDb() async {
    return openDatabase(join(await getDatabasesPath(), 'Labours.db'),
        onCreate: (db, version) {
      db.execute('CREATE TABLE labours(name TEXT,field TEXT)');
    }, version: 1);
  }

  static Future<void> addUser(LabourModel labourModel) async {
    final db = await getDb();
    await db.insert(
      'labours',
      labourModel.objToMap(),
    );
  }

  static Future<void> deleteUser(LabourModel labourModel) async {
    final db = await getDb();
    await db.delete('labours', where: 'name=?', whereArgs: [labourModel.name]);
  }

  static Future<List<LabourModel>?> getAllUsers() async {
    final db = await getDb();
    final List<Map<String, dynamic>> maps = await db.query('labours');
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
      maps.length,
      (index) {
        return LabourModel.mapToObj(maps[index]);
      },
    );
  }
}
