class TodoModel {
  final int taskId;
  final String taskTitle;
  final String taskDescription;
  final String taskTimer;
  final String taskStatus;

  TodoModel(
      {required this.taskId,
      required this.taskTitle,
      required this.taskDescription,
      required this.taskTimer,
      required this.taskStatus});

  factory TodoModel.fromMap(Map map) {
    return TodoModel(
        taskId: map['id'],
        taskTitle: map['title'],
        taskDescription: map['description'],
        taskTimer: map['timer'],
        taskStatus: map['status']);
  }
}


