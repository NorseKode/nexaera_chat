part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final User user;

  const AuthenticatedState({required this.user});
}

class AuthUnauthenticatedState extends AuthenticationState {}
