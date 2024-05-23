import 'package:flutter/cupertino.dart';
import 'package:todoapp/db_repo/db_repo.dart';

import '../../../model/todo_model.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModel> todoList = [];

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
