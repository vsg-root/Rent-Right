import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class HistoryDatabase {
  static late Database _database; // Alteração aqui

  HistoryDatabase._privateConstructor();

  static final HistoryDatabase instance = HistoryDatabase._privateConstructor();

  static Future<void> initialize() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'historydata.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE history(
            user TEXT,
            id TEXT,
            type TEXT,
            region TEXT,
            sqfeet INTEGER,
            baths INTEGER,
            beds INTEGER,
            comes_furnished INTEGER,
            wheelchair_access INTEGER,
            electric_vehicle_charge INTEGER,
            cats_allowed INTEGER,
            dogs_allowed INTEGER,
            smoking_allowed INTEGER,
            value REAL
          )
          ''');
      },
      version: 1,
    );
  }

  Future<void> insertHistory(Map<String, dynamic> row) async {
    await _database.insert('history', row);
  }

  Future<List<Map<String, dynamic>>> queryAllHistory() async {
    return await _database.query('history');
  }

  Future<List<Map<String, dynamic>>> queryHistory(String user) async {
    return await _database.query(
      'history',
      where: 'user = ?',
      whereArgs: [user],
    );
  }

  Future<void> updateHistory(String user, Map<String, dynamic> row) async {
    await _database.update(
      'history',
      row,
      where: 'user = ?',
      whereArgs: [user],
    );
  }

  Future<void> clearHistory() async {
    await _database.delete('history');
  }
}
