import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;

  const UserEntity({required this.email, required this.id});

  @override
  List<Object?> get props => [id, email];
}
