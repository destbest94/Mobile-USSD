import 'dart:async';

import 'package:mobile_ussd/database/CreateTables.dart';
import 'package:mobile_ussd/database/models/message/MessagePackagesGroupModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//url: http://ussd01.thelab.uz/api/message-packages-group/

class MessagePackagesGroupController {
  Database _db;
  final String _tableName = 'message_packages_group';

  Future<Database> database() async => openDatabase(
        join(await getDatabasesPath(), 'data.db'),
        onCreate: (db, version) => createTables(db),
        version: 1,
      );

  Future<List<MessagePackagesGroupModel>> majorOperation(
      {String mobileOperator,
      String language,
      List<dynamic> decodedJsonList}) async {
    _db = await database();
    MessagePackagesGroupModel model;

    if (decodedJsonList.length > 0) {
      for (var m in decodedJsonList) {
        model = MessagePackagesGroupModel.fromJson(m);
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

  Future<List<MessagePackagesGroupModel>> _getAll(
      {String mobileOperator, String language}) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      '$_tableName',
      where: 'mobile_operator = ? and language = ?',
      whereArgs: [mobileOperator.toLowerCase(), language],
    );

    return List.generate(
        maps.length, (i) => MessagePackagesGroupModel.fromJson(maps[i]));
  }

  Future<void> _inser(MessagePackagesGroupModel model) async {
    await _db.insert('$_tableName', model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> _update(MessagePackagesGroupModel model) async {
    return await _db.update('$_tableName', model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  Future<int> _delete(MessagePackagesGroupModel model) async {
    return await _db
        .delete('$_tableName', where: 'id = ?', whereArgs: [model.id]);
  }
}
