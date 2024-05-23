import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo_model.dart';

class DatabaseRepository {
  ///Create Database

  static Future<Database> db() async {
    return openDatabase('todoDb.db', version: 1,
        onCreate: (database, int version) async {
      await _createTable(database, version);
    });
  }

  ///create table
  static Future _createTable(Database db, int version) async {
    await db.execute('''create table todoTable ( 
                       id integer primary key autoincrement, 
                       title text not null,
                       description text not null,
                       status text not null,
                       timer text not null)   
                  ''');
  }

  /// insert record
  static Future createTask(
      String title, String description, String status, String timer) async {
    final db = await DatabaseRepository.db();

    final data = {
      'title': title,
      'description': description,
      'status': status,
      'timer': timer
    };
    final id = await db.insert('todoTable', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(id);
    // return id;
  }

  /// get data from database
  static Future getTasks() async {
    List<TodoModel> todoList = [];
    final db = await DatabaseRepository.db();
    var data = await db.query('todoTable', orderBy: 'id');
    for (var e in data) {
      todoList.add(TodoModel.fromMap(e));
    }
    return todoList;
  }

  /// get items by title
  static Future getTaskByTitle(String title) async {
    final db = await DatabaseRepository.db();
    List<TodoModel> todoList = [];
    var data = await db.query('todoTable', where: "title=?", whereArgs: [title]);
    for (var e in data) {
      todoList.add(TodoModel.fromMap(e));
    }
    return todoList;
  }

  /// update item
  static Future updateTask(int id, String title, String description,
      String status, String timer) async {
    final db = await DatabaseRepository.db();
    final data = {
      'title': title,
      'description': description,
      'status': status,
      'timer': timer
    };
    final result =
        await db.update('todoTable', data, where: "id=?", whereArgs: [id]);
    return result;
  }

  static Future updateTaskStatus(int id, String status) async {
    final db = await DatabaseRepository.db();
    // final data = {
    //   'title': title,
    //   'description': description,
    //   'status': status,
    //   'timer': timer
    // };
    final result = await db.update('todoTable', {'status': status},
        where: "id=?", whereArgs: [id]);
    return result;
  }

  ///delete item
  static Future deleteItem(int id) async {
    final db = await DatabaseRepository.db();
    try {
      await db.delete('todoTable', where: "id=?", whereArgs: [id]);
    } catch (e) {
      rethrow;
    }
  }
}
