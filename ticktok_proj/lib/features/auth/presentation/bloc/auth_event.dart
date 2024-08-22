part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent(this.email, this.password);
}

final class SignUpEvent extends AuthEvent {
  final String name;

  final String email;
  final String password;
  final File image;

  SignUpEvent(this.email, this.name, this.password, this.image);
}
