part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final String firstName;
  final String lastName;
  final String email;

  const UserLoaded(this.firstName, this.lastName, this.email);

  @override
  List<Object> get props => [firstName, lastName, email];
}

class UserLoading extends UserState {}

class UserError extends UserState {}
