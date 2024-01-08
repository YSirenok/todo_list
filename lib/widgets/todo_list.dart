import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_task.dart';
import 'todo_entry.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<TodoTask> tasks = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TodoEntry(
                  task: tasks[index],
                  onCheckboxChanged: (isChecked) {
                    setState(() {
                      tasks[index].isCompleted = isChecked;
                    });
                    _saveTasks();
                  },
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 32.0),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _taskController,
                  decoration: const InputDecoration(
                    hintText: 'Enter a new task',
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    _addTask(_taskController.text);
                  },
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList('tasks');

    if (taskList != null) {
      setState(() {
        tasks = taskList
            .map((taskJson) => TodoTask.fromJson(json.decode(taskJson)))
            .toList();
      });
    }
  }

  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskList =
        tasks.map((task) => json.encode(task.toJson())).toList();
    prefs.setStringList('tasks', taskList);
  }

  void _addTask(String taskName) {
    if (taskName.isNotEmpty) {
      setState(() {
        tasks.add(TodoTask(taskName: taskName));
        _taskController.clear();
        _saveTasks();
      });
    }
  }
}
