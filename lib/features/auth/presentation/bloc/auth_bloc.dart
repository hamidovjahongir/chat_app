import 'package:bloc/bloc.dart';
import 'package:chat_app/features/auth/data/models/auth_model.dart';
import 'package:chat_app/features/auth/data/repositories/auth_repositories.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositories  repository;
  
  AuthBloc(this.repository) : super(AuthState()) {
    on<RegisterEvent>(_register);
    on<LoginterEvent>(_login);

  }
  Future<void> _register(
    RegisterEvent event,
    Emitter emit,
  ) async {
    try {
      emit(AuthLoadingState());
      final data = await repository.register(event.user);
      emit(AuthSuccessState(data));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _login(
    LoginterEvent event,
    Emitter emit,
  ) async {
    try {
      emit(AuthLoadingState());
      final data = await repository.login(event.user);
      emit(AuthSuccessState(data));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
