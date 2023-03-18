part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserDetails extends UserEvent {
  final String userId;

  const GetUserDetails(this.userId);
}
