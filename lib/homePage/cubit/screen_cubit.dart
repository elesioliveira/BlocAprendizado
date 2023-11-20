import 'package:bloc/bloc.dart';

import 'package:flutter_application_cubit/homePage/cubit/screen_state.dart';

class ScreenCubit extends Cubit<ScreenState> {
  final List<String> _todos = [];
  List<String> get todos => _todos;

  ScreenCubit() : super(InitialScreenState());

  Future<void> addTodo({required String value}) async {
    emit(LoadingScreenState());

    await Future.delayed(const Duration(seconds: 2));

    if (_todos.contains(value)) {
      emit(ErrorScreenState(message: 'Voce já adicionou essa tarefa'));
    } else {
      _todos.add(value);
      emit(LoadedScreenState(todos: _todos));
    }
  }

  Future<void> removeValue({required int index}) async {
    emit(LoadingScreenState());

    await Future.delayed(const Duration(seconds: 2));
    _todos.removeAt(index);

    if (_todos.isEmpty) {
      emit(InitialScreenState());
    } else {
      emit(LoadedScreenState(todos: _todos));
    }
  }
}
