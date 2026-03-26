import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksync/features/auth/data/models/user_model.dart';
import 'package:tasksync/features/auth/presentation/bloc/auth_event.dart';
import 'package:tasksync/features/auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  final UserModel? user;

  const HomePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskSync - Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            Navigator.of(context).pushReplacementNamed('/');
          }
        },
        child: Center(
          child: Text(
            'Bem-vindo ao TaskSync, ${user?.email}!\nVocê está logado.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
