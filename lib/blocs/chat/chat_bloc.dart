import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:nexaera_chat/data/models/prompt_input.dart';
import 'package:nexaera_chat/data/models/chat_model.dart';
import 'package:nexaera_chat/data/models/promt_output.dart';
import 'package:nexaera_chat/data/repositories/server_repository.dart';
import 'package:nexaera_chat/presentation/constants/chat_roles.dart';
import 'package:nexaera_chat/presentation/constants/promt_finish_reason.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  String? sessionId;
  ChatBloc(this._serverRepository) : super(const ChatInitial([])) {
    on<CreateChatSession>((event, emit) async {
      emit(ChatLoading(state.chatMessages));
      sessionId = await _serverRepository.createSession(event.domain);
      emit(ChatIdle(state.chatMessages));
    });

    on<SendChatMessage>((event, emit) async {
      var messages = state.chatMessages.toList();
      messages.add(ChatModel(ChatRole.user, event.message));
      emit(ChatLoading(messages));

      var prompt =
          PromptInputModel(sessionId: sessionId!, message: event.message);

      try {
        await emit.forEach(
          _serverRepository.sendPromptMessage(prompt),
          onData: (PromptOutputModel output) {
            messages.add(ChatModel(ChatRole.chatbot, output.promtOutput));
            if (output.finishReason == PromptFinishReason.stop) {
              return ChatSuccess(messages);
            } else {
              return ChatError(messages,
                  output.finishReason.name + output.status['message']);
            }
          },
        );

        emit(ChatIdle(messages));
      } catch (e) {
        messages.add(ChatModel(ChatRole.chatbot, 'Something went wrong: $e'));
        emit(ChatIdle(messages));
      }
    });
  }

  final ServerRepository _serverRepository;
}
