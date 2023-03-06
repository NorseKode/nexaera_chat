part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SigningIn extends SignInEvent {
  final String email;
  final String password;

  SigningIn(this.email, this.password);
}
