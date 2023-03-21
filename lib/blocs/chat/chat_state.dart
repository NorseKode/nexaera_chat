part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatWriting extends ChatState {
  final String message;
  const ChatWriting(this.message);

  @override
  List<Object> get props => [message];
}

class ChatError extends ChatState {
  final String errorMessage;
  const ChatError(this.errorMessage);
}

class ChatIdle extends ChatState {}
