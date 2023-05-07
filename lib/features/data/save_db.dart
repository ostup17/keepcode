import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = "translates.db";
  static final _tableName = "services";
  static final _columnRu = "ru";
  static final _columnEn = "en";
  static final _columnKeywords = "keywords";
  static final _columnId = "id";
  static final _columnSellTop = "sellTop";

  static Future<Database> _database() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE $_tableName (
            $_columnId TEXT,
            $_columnRu TEXT,
            $_columnEn TEXT,
            $_columnKeywords TEXT,
            $_columnSellTop TEXT
          )
          ''');
    });
  }

  static Future<void> saveJsonToDb(Map<String, dynamic> jsonString) async {
    // final data = json.decode(jsonString) as Map<String, dynamic>;
    final db = await _database();
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM services'));
    print(count);
    print(count.runtimeType);
    if (count == 0) {
      await db.transaction((txn) async {
        for (final MapEntry<String, dynamic> entry in jsonString['services'].entries) {
          final serviceKey = entry.key;
          final service = entry.value;

          await txn.insert(_tableName, {
            _columnId: serviceKey,
            _columnRu: service['ru'],
            _columnEn: service['en'],
            _columnKeywords: service['keywords'],
            _columnSellTop: service['sellTop'],
          });
        }
      });
    }
  }

  static Future<String?> searchEnValue(String key) async {
    final db = await _database();
    final test = await db.query(_tableName);
    print(test);
    final result = await db.query(_tableName,
        columns: [_columnEn], where: '$_columnId = ?', whereArgs: [key]);
    if (result.isNotEmpty) {
      return result.first[_columnEn] as String;
    } else {
      return null;
    }
  }
}
