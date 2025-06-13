part of 'auth_bloc.dart';
class AuthEvent {}

class RegisterEvent extends AuthEvent {
  AuthModel user;
  RegisterEvent(this.user);
}
class LoginterEvent extends AuthEvent {
  AuthModel user;
  LoginterEvent(this.user);
}
