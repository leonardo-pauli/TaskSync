import 'package:tasksync/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity?> get user;
  Future<UserEntity> signInWithEmail({
    required String email,
    required String password,
  });
  Future<UserEntity> signUpWithEmail({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
