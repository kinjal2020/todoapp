

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/db_repo/db_repo.dart';

import '../../../model/todo_model.dart';

class TodoProvider with ChangeNotifier {
  bool isDark = false;

  List<TodoModel> todoList = [];

  SharedPreferences? pref;

  TodoProvider() {
    sharedPref();
  }

  sharedPref() async {
    pref = await SharedPreferences.getInstance();
    getThemeData();
  }

  get themeStatus => isDark;

  set themeStatus(value) {
    isDark = value;
    setThemeData(value);
    notifyListeners();
  }

  setThemeData(value) {
    pref!.setBool('isDark', value);
  }

  getThemeData() {
    isDark =  pref!.getBool('isDark') ?? false;
    notifyListeners();
  }

  addTask(String title, String description, String status, String timer) async {
    await DatabaseRepository.createTask(title, description, status, timer);
  }

  getTaskList() async {
    await DatabaseRepository.getTasks().then((value) {
      todoList = value;
    });
    notifyListeners();
  }

  searchTask(String title) async {
    await DatabaseRepository.getTaskByTitle(title).then((value) {
      todoList = value;
    });
    notifyListeners();
  }

  deleteTask(int id) async {
    await DatabaseRepository.deleteItem(id);
  }

  updateTaskStatus(String status, int id) async {
    await DatabaseRepository.updateTaskStatus(id, status);
  }

  updateTask(String title, String description, String status, String timer,
      int id) async {
    await DatabaseRepository.updateTask(id, title, description, status, timer);
  }
}
