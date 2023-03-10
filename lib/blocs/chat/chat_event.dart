part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class CreateChatSession extends ChatEvent {
  final String domain;
  const CreateChatSession(this.domain);
}

class SendChatMessage extends ChatEvent {
  final String message;
  const SendChatMessage(this.message);
}
