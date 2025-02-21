import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // create merge pathes (win , android , ios ..etc)
import 'package:taxi_grad/core/utils/app_texts.dart' show AppTexts;

class DBHelper {
  static final DBHelper singleton = DBHelper.internal();
  factory DBHelper() => singleton;
  static Database? _db;
  DBHelper.internal();
  static DBHelper shared() => singleton;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'data.db');
    var isDBExists = await databaseExists(path);
    if (kDebugMode) {
      print(isDBExists);
      print(path);
    }
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  void onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE ${AppTexts.tbZoneList} (${AppTexts.zoneId} TEXT PRIMARY KEY, '
        '${AppTexts.zoneName} TEXT, ${AppTexts.zoneJson} TEXT, ${AppTexts.city} TEXT, '
        '${AppTexts.tax} TEXT, ${AppTexts.status} Text, ${AppTexts.createdDate} Text, ${AppTexts.modifyDate} Text)');

    await db.execute(
        'CREATE TABLE ${AppTexts.tbServiceDetail} (${AppTexts.serviceId} TEXT PRIMARY KEY, '
        '${AppTexts.serviceName} TEXT, ${AppTexts.seat} TEXT, ${AppTexts.color} TEXT, '
        '${AppTexts.icon} TEXT, ${AppTexts.topIcon} TEXT, ${AppTexts.gender} TEXT, '
        '${AppTexts.description} TEXT, ${AppTexts.status} TEXT, ${AppTexts.createdDate} TEXT, ${AppTexts.modifyDate} TEXT)');

    await db.execute(
        'CREATE TABLE ${AppTexts.tbPriceDetail} (${AppTexts.priceId} TEXT PRIMARY KEY, '
        '${AppTexts.zoneId} TEXT, ${AppTexts.serviceId} TEXT, ${AppTexts.baseCharge} TEXT, '
        '${AppTexts.perKmCharge} TEXT, ${AppTexts.perMinCharge} TEXT, ${AppTexts.bookingCharge} TEXT, '
        '${AppTexts.miniFair} TEXT, ${AppTexts.miniKm} TEXT, ${AppTexts.cancelCharge} TEXT, '
        '${AppTexts.tax} TEXT, ${AppTexts.status} TEXT, ${AppTexts.createdDate} TEXT, ${AppTexts.modifyDate} TEXT)');

    await db.execute(
        'CREATE TABLE ${AppTexts.tbDocument} (${AppTexts.docId} TEXT PRIMARY KEY, '
        '${AppTexts.name} TEXT, ${AppTexts.type} TEXT, ${AppTexts.status} TEXT, '
        '${AppTexts.createdDate} TEXT, ${AppTexts.modifyDate} TEXT)');

    await db.execute(
        'CREATE TABLE ${AppTexts.tbZoneDocument} (${AppTexts.zoneDocId} TEXT PRIMARY KEY, '
        '${AppTexts.zoneId} TEXT, ${AppTexts.serviceId} TEXT, ${AppTexts.personalDoc} TEXT, '
        '${AppTexts.carDoc} TEXT, ${AppTexts.requiredPersonalDoc} TEXT, ${AppTexts.requiredCarDoc} TEXT, '
        '${AppTexts.status} TEXT, ${AppTexts.createdDate} TEXT, ${AppTexts.modifyDate} TEXT)');

    debugPrint("Database tables created");
  }

  static Future dbClearAll() async {
    if (_db == null) return;

    await _db?.execute('DELETE FROM ${AppTexts.tbZoneList}');
    await _db?.execute('DELETE FROM ${AppTexts.tbServiceDetail}');
    await _db?.execute('DELETE FROM ${AppTexts.tbPriceDetail}');
    await _db?.execute('DELETE FROM ${AppTexts.tbDocument}');
    await _db?.execute('DELETE FROM ${AppTexts.tbZoneDocument}');
  }

  static Future dbClearTable(String table) async {
    if (_db == null) return;
    await _db?.execute('DELETE FROM $table');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient?.close();
  }
}
