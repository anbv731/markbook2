
import 'package:markbook2/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'example.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE marks(id INTEGER PRIMARY KEY AUTOINCREMENT, list_id INTEGER NOT NULL, note TEXT NOT NULL, done INTEGER NOT NULL, priority INTEGER NOT NULL,FOREIGN KEY (list_id) REFERENCES lists (id) ON DELETE CASCADE ON UPDATE CASCADE,)",
        );
        await database.execute(
          "CREATE TABLE lists(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)",
        );
      },
      onConfigure: _onConfigure,
      version: 1,
    );
  }
  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
  Future<int> insertMark(List<Mark> marks) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var mark in marks){
      result = await db.insert('marks', mark.toMap());
    }
    return result;
  }

  Future<int> insertList(List<ListModel> lists) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var list in lists){
      result = await db.insert('marks', list.toMap());
    }
    return result;
  }

  Future<List<Mark>> retrieveMarks() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('marks');
    return queryResult.map((e) => Mark.fromMap(e)).toList();
  }
  Future<List<ListModel>> retrieveLists() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('lists');
    return queryResult.map((e) => ListModel.fromMap(e)).toList();
  }
  Future<void> delete(String table, int id) async {
    final db = await initializeDB();
    await db.delete(
      table,
      where: "id = ?",
      whereArgs: [id],
    );
  }
  Future<List<ListModel>> queryList(int listId) async {

    final Database db = await initializeDB();
    String table ='marks';
    final List<Map<String, Object?>> result = await db.query(table,
        columns: ['id','list_id','note','done','priority'],
        where: 'list_id= ?',
        whereArgs: [listId]);
    return result.map((e) => ListModel.fromMap(e)).toList();
  }
  Future<List<Mark>> queryListId(int listId) async {

    final Database db = await initializeDB();
    String table ='marks';
    final List<Map<String, Object?>> result = await db.query(table,
        columns: ['list_id'],
        where: 'list_id= ?',
        whereArgs: [listId]);
    print('start ${result.map((e) => Mark.fromMap(e)).toList().length}');
    return result.map((e) => Mark.fromMap(e)).toList();
  }

  Future<void> update( Mark mark) async {
    final Database db = await initializeDB();
    await db.update('marks', mark.toMap(), where: 'id = ?', whereArgs: [mark.getId]);
  }
  Future<void> replace( int oldId, int newId) async {

    final Database db = await initializeDB();
    final List<Map<String, Object?>> mark = await db.query('marks',
        columns: ['id, list_id, note, done, priority'],
        where: 'id= ?',
        whereArgs: [oldId]);
    final List<Map<String, Object?>> mark1 = await db.query('marks',
        columns: ['id, list_id, note, done, priority'],
        where: 'id= ?',
        whereArgs: [newId]);

    await db.update('marks', mark[0], where: 'id = ?', whereArgs: [newId]);
    await db.update('marks', mark1[0], where: 'id = ?', whereArgs: [oldId]);
  }
}