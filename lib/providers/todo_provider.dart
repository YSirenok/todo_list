import 'package:flutter/foundation.dart';
import '../models/todo_task.dart';

class TodoProvider extends ChangeNotifier {
  final List<TodoTask> _tasks = [];

  List<TodoTask> get tasks => _tasks;

  void addTask(TodoTask task) {
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(TodoTask task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
