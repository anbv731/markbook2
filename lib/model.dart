import 'package:flutter/material.dart';
import 'package:markbook2/services/DatabaseHandler.dart';

DatabaseHandler _handler = DatabaseHandler();

class ListOfToDoLists extends ChangeNotifier {
  List<ToDoListModel> _list = [];

  List<ToDoListModel> get getList => _list;

  void addData(ToDoListModel newToDoList) {
    _list.add(newToDoList);
    notifyListeners();
  }

  void addList() {
    _list.add(ToDoListModel());
    notifyListeners();
  }

  void removeData(int index) {
    _list.removeAt(index);
    notifyListeners();
  }

  void insertData(int index, ToDoListModel newToDoList) {
    _list.insert(index, newToDoList);
    notifyListeners();
  }
}

class ToDoListModel {
  List<Mark> _data = [];

  //MarkModel _newMark;

  List<Mark> get getData => _data;

  void newData(List<Mark> _newToDoList) {
    _data = _newToDoList;
  }

  void addData(Mark newMark) {
    _data.add(newMark);
  }

  void addMark() {
    _data.add(Mark());
  }

  void removeData(int index) {
    _data.removeAt(index);
  }

  void insertData(int oldIndex, int newIndex) {
    Mark _tempMark = Mark();
    _tempMark = _data[oldIndex];
    _data.removeAt(oldIndex);
    _data.insert(newIndex, _tempMark);
  }
}

class ListModel {
  ListModel();
  int? _id;
  String? _name;

  void changeName(
    String newName,
  ) {
    _name = newName;
  }

  ListModel.fromMap(Map<String, dynamic> res)
      : _id = res['id'],
        _name = res['name'];

  Map<String, Object?> toMap() {
    return {
      'id': _id,
      'name': _name,
    };
  }
}

class Mark {
  Mark();

  int? _id;

  int get getId => _id ?? 0;

  int _listId = 0;

  int get getListId => _listId;

  String _note = '';

  String get getNote => _note;
  int _done = 0;

  bool get getDone => _done as bool;
  int _priority = 0;

  bool get getPriority => _priority as bool;

  void changeNote(
    String newNote,
  ) {
    _note = newNote;
  }
  void changeId(
      int newId,
      ) {
    _id = newId;
  }

  void changeListId(int listId) {
    _listId = listId;
  }

  void changeDone() {
    (_done) == 0 ? _done = 1 : _done = 0;
  }

  void changePriority() {
    _priority == 0 ? _priority = 1 : _priority = 0;
  }

  Mark.fromMap(Map<String, dynamic> res)
      : _id = res['id'],
        _listId = res['list_id'],
        _note = res['note'],
        _done = res['done'],
        _priority = res['priority'];

  Map<String, Object?> toMap() {
    return {
      'id': _id,
      'list_id': _listId,
      'note': _note,
      'done': _done,
      'priority': _priority
    };
  }
}
