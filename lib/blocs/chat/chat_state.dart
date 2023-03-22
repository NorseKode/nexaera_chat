part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState(this.messages);
  final List<ChatModel> messages;

  @override
  List<Object> get props => [messages];
}

class ChatInitial extends ChatState {
  ChatInitial(super.messages);
}

class ChatLoading extends ChatState {
  ChatLoading(super.messages);
}

class ChatWriting extends ChatState {
  final String message;
  const ChatWriting(this.message, super.messages);

  @override
  List<Object> get props => [message];
}

class ChatError extends ChatState {
  final String errorMessage;
  const ChatError(this.errorMessage, super.messages);
}

class ChatIdle extends ChatState {
  ChatIdle(super.messages);
}
