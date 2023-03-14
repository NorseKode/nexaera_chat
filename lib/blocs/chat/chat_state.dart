part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState(this.chatMessages);
  final List<ChatModel> chatMessages;

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial(super.chatMessages);
}

class ChatLoading extends ChatState {
  const ChatLoading(super.chatMessages);
}

class ChatSuccess extends ChatState {
  const ChatSuccess(super.chatMessages);
}

class ChatError extends ChatState {
  final String errorMessage;
  const ChatError(super.chatMessages, this.errorMessage);
}

class ChatIdle extends ChatState {
  const ChatIdle(super.chatMessages);
}
