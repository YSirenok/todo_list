import 'package:flutter/material.dart';
import '../models/todo_task.dart';

class TodoEntry extends StatelessWidget {
  final TodoTask task;
  final Function(bool) onCheckboxChanged;

  const TodoEntry(
      {super.key, required this.task, required this.onCheckboxChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.taskName,
        style: TextStyle(
          decoration: task.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          onCheckboxChanged(value!);
        },
      ),
      onTap: () {
        onCheckboxChanged(!task.isCompleted);
      },
    );
  }
}
