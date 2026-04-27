import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasksync/features/tasks/presentation/bloc/task_bloc.dart';

// Imports de Autenticação
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/home/presentation/pages/login_page.dart';

// Imports de Tarefas
import 'package:tasksync/features/tasks/data/repositories/task_repositories_impl.dart';

import 'package:tasksync/features/home/presentation/pages/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: AuthRepositoryImpl(
              firebaseAuth: FirebaseAuth.instance,
            ),
          ),
        ),
        BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(
            taskRepository: TaskRepositoryImpl(
              firestore: FirebaseFirestore.instance,
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'TaskSync',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
