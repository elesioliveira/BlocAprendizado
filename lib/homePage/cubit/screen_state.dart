abstract class ScreenState {}

class InitialScreenState extends ScreenState {}

class LoadingScreenState extends ScreenState {}

class LoadedScreenState extends ScreenState {
  final List<String> todos;

  LoadedScreenState({required this.todos});
}

class ErrorScreenState extends ScreenState {
  final String message;

  ErrorScreenState({required this.message});
}
