import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todotdd/domain/repositories/task_repository.dart';
import 'package:todotdd/presentation/bloc/task_event.dart';
import 'package:todotdd/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc({required this.taskRepository}) : super(TasksInitial()){
    on<LoadTasksEvent>(onLoadTasksEvent);
    on<AddTaskEvent>(onAddTaskEvent);
    on<UpdateTaskEvent>(onUpdateTaskEvent);
    on<DeleteTaskEvent>(onDeleteTaskEvent);
  }

  void onLoadTasksEvent(event, emit) async {
    print("-- call LoadTasksEvent --");
    try {
      final tasks = await taskRepository.getTasks();
      emit(TasksLoaded(tasks));
    } catch (error) {
      emit(TasksError("Erreur lors du chargement des tâches"));
    }
  }

  void onAddTaskEvent(event, emit) async {
    print("-- call onAddTaskEvent --");
    try {
      await taskRepository.addTask(event.task);
      final tasks = await taskRepository.getTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  void onUpdateTaskEvent(event, emit) async {
    print("-- call onUpdateTaskEvent --");
    try {
      await taskRepository.updateTask(event.task);
      final tasks = await taskRepository.getTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

  void onDeleteTaskEvent(event, emit) async {
    print("-- call onDeleteTaskEvent --");
    try {
      await taskRepository.deleteTask(event.taskId);
      final tasks = await taskRepository.getTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TasksError(e.toString()));
    }
  }

}
