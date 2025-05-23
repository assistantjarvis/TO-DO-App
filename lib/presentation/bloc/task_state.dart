import '../../domain/entities/task.dart';

abstract class TaskState {}

class TasksInitial extends TaskState {}

class TasksLoaded extends TaskState {
  final List<Task> tasks;

  TasksLoaded(this.tasks);
}

class TasksLoading extends TaskState {}

class TasksError extends TaskState {
  final String message;

  TasksError(this.message);
}
