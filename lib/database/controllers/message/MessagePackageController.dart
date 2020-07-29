import 'dart:async';

import 'package:mobile_ussd/database/CreateTables.dart';
import 'package:mobile_ussd/database/models/message/MessagePackageModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//url: http://ussd01.thelab.uz/api/message-package

class MessagePackageController {
  Database _db;
  final String _tableName = 'message_package';

  Future<Database> database() async => openDatabase(
        join(await getDatabasesPath(), 'data.db'),
        onCreate: (db, version) => createTables(db),
        version: 1,
      );

  Future<List<MessagePackageModel>> majorOperation(
      {List<String> groupsId, List<dynamic> decodedJsonList}) async {
    _db = await database();
    MessagePackageModel model;

    if (decodedJsonList.length > 0) {
      for (var m in decodedJsonList) {
        model = MessagePackageModel.fromJson(m);
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

  Future<List<MessagePackageModel>> _getAll(
      {List<String> groupsId}) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      '$_tableName',
      where: 'message_packages_group IN (${groupsId.map((e) => '?').join(',')})',
      whereArgs: [...groupsId],
      orderBy: 'id DESC',
    );

    return List.generate(
        maps.length, (i) => MessagePackageModel.fromJson(maps[i]));
  }

  Future<void> _inser(MessagePackageModel model) async {
    await _db.insert('$_tableName', model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> _update(MessagePackageModel model) async {
    return await _db.update('$_tableName', model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  Future<int> _delete(MessagePackageModel model) async {
    return await _db
        .delete('$_tableName', where: 'id = ?', whereArgs: [model.id]);
  }
}
