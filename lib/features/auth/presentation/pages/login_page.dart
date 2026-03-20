import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksync/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tasksync/features/auth/presentation/bloc/auth_event.dart';
import 'package:tasksync/features/auth/presentation/bloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TaskSync - Login")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthAuthenticated) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      SignInRequested(
                        _emailController.text,
                        _passwordController.text,
                      ),
                    );
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
