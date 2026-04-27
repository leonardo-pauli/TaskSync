import 'package:tasksync/features/tasks/domain/entities/task_entity.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getTasks(String userId);
  Future<void> addTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(String taskId);
}
