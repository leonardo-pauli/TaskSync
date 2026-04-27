import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/task_entity.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final FirebaseFirestore firestore;

  TaskRepositoryImpl({required this.firestore});

  @override
  Future<List<TaskEntity>> getTasks(String userId) async {
    final snapshot = await firestore
        .collection('tasks')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      return TaskModel.fromJson(doc.data(), doc.id);
    }).toList();
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    final taskModel = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
      userId: task.userId,
    );

    await firestore
        .collection('tasks')
        .doc(taskModel.id)
        .set(taskModel.toJson());
  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    final taskModel = TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
      userId: task.userId,
    );

    await firestore.collection('tasks').doc(task.id).update(taskModel.toJson());
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await firestore.collection('tasks').doc(taskId).delete();
  }
}
