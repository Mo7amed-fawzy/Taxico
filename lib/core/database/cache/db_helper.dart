import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart'; // create merge pathes (win , android , ios ..etc)
import 'package:taxi_grad/core/utils/app_strings.dart' show AppStrings;

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
        'CREATE TABLE ${AppStrings.tbZoneList} (${AppStrings.zoneId} TEXT PRIMARY KEY, '
        '${AppStrings.zoneName} TEXT, ${AppStrings.zoneJson} TEXT, ${AppStrings.city} TEXT, '
        '${AppStrings.tax} TEXT, ${AppStrings.status} Text, ${AppStrings.createdDate} Text, ${AppStrings.modifyDate} Text)');

    await db.execute(
        'CREATE TABLE ${AppStrings.tbServiceDetail} (${AppStrings.serviceId} TEXT PRIMARY KEY, '
        '${AppStrings.serviceName} TEXT, ${AppStrings.seat} TEXT, ${AppStrings.color} TEXT, '
        '${AppStrings.icon} TEXT, ${AppStrings.topIcon} TEXT, ${AppStrings.gender} TEXT, '
        '${AppStrings.description} TEXT, ${AppStrings.status} TEXT, ${AppStrings.createdDate} TEXT, ${AppStrings.modifyDate} TEXT)');

    await db.execute(
        'CREATE TABLE ${AppStrings.tbPriceDetail} (${AppStrings.priceId} TEXT PRIMARY KEY, '
        '${AppStrings.zoneId} TEXT, ${AppStrings.serviceId} TEXT, ${AppStrings.baseCharge} TEXT, '
        '${AppStrings.perKmCharge} TEXT, ${AppStrings.perMinCharge} TEXT, ${AppStrings.bookingCharge} TEXT, '
        '${AppStrings.miniFair} TEXT, ${AppStrings.miniKm} TEXT, ${AppStrings.cancelCharge} TEXT, '
        '${AppStrings.tax} TEXT, ${AppStrings.status} TEXT, ${AppStrings.createdDate} TEXT, ${AppStrings.modifyDate} TEXT)');

    await db.execute(
        'CREATE TABLE ${AppStrings.tbDocument} (${AppStrings.docId} TEXT PRIMARY KEY, '
        '${AppStrings.name} TEXT, ${AppStrings.type} TEXT, ${AppStrings.status} TEXT, '
        '${AppStrings.createdDate} TEXT, ${AppStrings.modifyDate} TEXT)');

    await db.execute(
        'CREATE TABLE ${AppStrings.tbZoneDocument} (${AppStrings.zoneDocId} TEXT PRIMARY KEY, '
        '${AppStrings.zoneId} TEXT, ${AppStrings.serviceId} TEXT, ${AppStrings.personalDoc} TEXT, '
        '${AppStrings.carDoc} TEXT, ${AppStrings.requiredPersonalDoc} TEXT, ${AppStrings.requiredCarDoc} TEXT, '
        '${AppStrings.status} TEXT, ${AppStrings.createdDate} TEXT, ${AppStrings.modifyDate} TEXT)');

    debugPrint("Database tables created");
  }

  static Future dbClearAll() async {
    if (_db == null) return;

    await _db?.execute('DELETE FROM ${AppStrings.tbZoneList}');
    await _db?.execute('DELETE FROM ${AppStrings.tbServiceDetail}');
    await _db?.execute('DELETE FROM ${AppStrings.tbPriceDetail}');
    await _db?.execute('DELETE FROM ${AppStrings.tbDocument}');
    await _db?.execute('DELETE FROM ${AppStrings.tbZoneDocument}');
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
