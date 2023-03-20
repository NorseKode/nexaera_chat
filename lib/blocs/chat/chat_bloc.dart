import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/prompt_input.dart';
import '../../data/models/chat_model.dart';
import '../../data/models/promt_output.dart';
import '../../data/repositories/server_repository.dart';
import '../../presentation/constants/chat_roles.dart';
import '../../presentation/constants/promt_finish_reason.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  String? sessionId;
  ChatBloc(this._serverRepository) : super(const ChatInitial([])) {
    on<CreateChatSession>((event, emit) async {
      var messages = state.chatMessages.toList();

      emit(ChatLoading(messages));
      try {
        sessionId = await _serverRepository.createSession(event.domain);
        emit(ChatIdle(state.chatMessages));
      } catch (e) {
        //Log errors
        print(e);
        emit(ChatError(messages, "Couldn't establish connection"));
      }
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
        messages.add(ChatModel(ChatRole.chatbot, 'Something went wrong'));
        emit(ChatError(messages, e.toString()));
      }
    });
  }

  final ServerRepository _serverRepository;
}
