class TodoTask {
  final String taskName;
  bool isCompleted;

  TodoTask({required this.taskName, this.isCompleted = false});

  TodoTask copyWith({bool? isCompleted}) {
    return TodoTask(
      taskName: taskName,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'isCompleted': isCompleted,
    };
  }

  factory TodoTask.fromJson(Map<String, dynamic> json) {
    return TodoTask(
      taskName: json['taskName'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }
}
