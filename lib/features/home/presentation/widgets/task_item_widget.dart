import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasksync/features/tasks/domain/entities/task_entity.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskEntity task;
  final ValueChanged<bool?> onToggle;
  final VoidCallback onDelete;

  const TaskItemWidget({
    required this.task,
    required this.onToggle,
    required this.onDelete,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(task.description),
        leading: Checkbox(value: task.isCompleted, onChanged: onToggle),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
