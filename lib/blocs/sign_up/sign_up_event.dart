part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignedUp extends SignUpEvent {}

class SigningUp extends SignUpEvent {
  final String email;
  final String password;

  SigningUp(this.email, this.password);
}
