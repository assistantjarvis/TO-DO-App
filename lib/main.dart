import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotdd/data/repositories/mock_task_repository.dart';
import 'package:todotdd/domain/repositories/task_repository.dart';
import 'package:todotdd/presentation/bloc/task_bloc.dart';
import 'package:todotdd/presentation/bloc/task_event.dart';
import 'package:todotdd/presentation/pages/tasks_page.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final TaskRepository taskRepository = MockTaskRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) =>
            TaskBloc(taskRepository: taskRepository)..add(LoadTasksEvent()),
        child: TasksPage(),
      ),
    );
  }
}
