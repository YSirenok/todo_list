// widgets/todo_list.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo_task.dart';
import '../providers/todo_provider.dart';
import 'todo_entry.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<TodoProvider>(
              builder: (context, todoProvider, child) {
                final tasks = todoProvider.tasks;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TodoEntry(
                      task: tasks[index],
                      onCheckboxChanged: (isChecked) {
                        todoProvider.removeTask(tasks[index]);
                        todoProvider.addTask(
                          tasks[index].copyWith(isCompleted: isChecked),
                        );
                      },
                    );
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
                    final taskName = _taskController.text;
                    if (taskName.isNotEmpty) {
                      context.read<TodoProvider>().addTask(
                            TodoTask(taskName: taskName),
                          );
                      _taskController.clear();
                    }
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
}

