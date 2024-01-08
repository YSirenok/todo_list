// lib/widgets/todo_entry.dart
import 'package:flutter/material.dart';
import '../models/todo_task.dart';

class TodoEntry extends StatefulWidget {
  final TodoTask task;
  final Function(bool) onCheckboxChanged;

  const TodoEntry(
      {super.key, required this.task, required this.onCheckboxChanged});

  @override
  TodoEntryState createState() => TodoEntryState();
}

class TodoEntryState extends State<TodoEntry> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.task.taskName,
        style: TextStyle(
          decoration: widget.task.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      leading: Checkbox(
        value: widget.task.isCompleted,
        onChanged: (value) {
          widget.onCheckboxChanged(value!);
        },
      ),
      onTap: () {
        widget.onCheckboxChanged(!widget.task.isCompleted);
      },
    );
  }
}
