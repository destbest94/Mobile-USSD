import 'dart:async';

import 'package:mobile_ussd/database/CreateTables.dart';
import 'package:mobile_ussd/database/models/internet/InternetPackageGroupModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//url: http://ussd01.thelab.uz/api/internet-packages-group/

class InternetPackagesGroupController {
  Database _db;
  final String _tableName = 'internet_packages_group';

  Future<Database> database() async => openDatabase(
        join(await getDatabasesPath(), 'data.db'),
        onCreate: (db, version) => createTables(db),
        version: 1,
      );

  Future<List<InternetPackagesGroupModel>> majorOperation(
      {String mobileOperator,
      String language,
      List<dynamic> decodedJsonList}) async {
    _db = await database();
    InternetPackagesGroupModel model;

    if (decodedJsonList.length > 0) {
      for (var m in decodedJsonList) {
        model = InternetPackagesGroupModel.fromJson(m);
        switch (model.historyType) {
          case '-':
            await _delete(model);
            break;

          case '~':
            await _update(model);
            break;

          default:
            await _inser(model);
        }
      }
    }

    dynamic all =
        await _getAll(mobileOperator: mobileOperator, language: language);
    await _db.close();
    return all;
  }

  Future<List<InternetPackagesGroupModel>> _getAll(
      {String mobileOperator, String language}) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      '$_tableName',
      where: 'mobile_operator = ? and language = ?',
      whereArgs: [mobileOperator.toLowerCase(), language],
    );

    return List.generate(
        maps.length, (i) => InternetPackagesGroupModel.fromJson(maps[i]));
  }

  Future<void> _inser(InternetPackagesGroupModel model) async {
    await _db.insert('$_tableName', model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> _update(InternetPackagesGroupModel model) async {
    return await _db.update('$_tableName', model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  Future<int> _delete(InternetPackagesGroupModel model) async {
    return await _db
        .delete('$_tableName', where: 'id = ?', whereArgs: [model.id]);
  }
}
