import 'dart:async';

import 'package:mobile_ussd/database/CreateTables.dart';
import 'package:mobile_ussd/database/models/ussd/UssdCodeModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//url: hhttp://ussd01.thelab.uz/api/ussd-code

class UssdCodeController {
  Database _db;
  final String _tableName = 'ussd_code';

  Future<Database> database() async => openDatabase(
        join(await getDatabasesPath(), 'data.db'),
        onCreate: (db, version) => createTables(db),
        version: 1,
      );

  Future<List<UssdCodeModel>> majorOperation(
      {List<String> groupsId, List<dynamic> decodedJsonList}) async {
    _db = await database();
    UssdCodeModel model;

    if (decodedJsonList.length > 0) {
      for (var m in decodedJsonList) {
        model = UssdCodeModel.fromJson(m);
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

    dynamic all = (groupsId == null) ? null : await _getAll(groupsId: groupsId);
    await _db.close();
    return all;
  }

  Future<List<UssdCodeModel>> _getAll(
      {List<String> groupsId}) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      '$_tableName',
      where: 'ussd_codes_group IN (${groupsId.map((e) => '?').join(',')})',
      whereArgs: [...groupsId],
      orderBy: 'id DESC',
    );

    return List.generate(
        maps.length, (i) => UssdCodeModel.fromJson(maps[i]));
  }

  Future<void> _inser(UssdCodeModel model) async {
    await _db.insert('$_tableName', model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> _update(UssdCodeModel model) async {
    return await _db.update('$_tableName', model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  Future<int> _delete(UssdCodeModel model) async {
    return await _db
        .delete('$_tableName', where: 'id = ?', whereArgs: [model.id]);
  }
}
