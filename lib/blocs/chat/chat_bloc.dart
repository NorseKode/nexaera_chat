import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/models/prompt_input.dart';
import '../../data/models/chat_model.dart';
import '../../data/models/promt_output.dart';
import '../../data/repositories/chat_repository.dart';
import '../../data/repositories/server_repository.dart';
import '../../presentation/constants/chat_roles.dart';
import '../../presentation/constants/promt_finish_reason.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  String? sessionId;
  ChatBloc(this._serverRepository, this._chatRepository)
      : super(ChatInitial()) {
    on<CreateChatSession>((event, emit) async {
      emit(ChatLoading());

      try {
        sessionId = await _serverRepository.createSession(event.domain);
        //Should be changes to createSession instead of hardcoded.
        await _chatRepository.connect('serach_rows_columns_kekw');
        emit(ChatIdle());
      } catch (e) {
        //Log errors
        print(e);
        emit(const ChatError("Couldn't establish connection"));
      }
    });

    on<SendChatMessage>(
      (event, emit) async {
        emit(ChatLoading());

        //Save message in firebase before
        await _chatRepository.send({'promptInput': event.message});

        var message = '';

        try {
          await emit.forEach(
            _chatRepository.receive(),
            onData: (PromptOutputModel output) {
              message += output.promtOutput;
              if (output.finishReason == null) {
                print('writing ' + message);
                return ChatWriting(message);
              } else if (output.finishReason == PromptFinishReason.stop) {
                //Save message in firebase before
                print('done ' + message);
                return ChatIdle();
              } else {
                print('error ' + message);
                return ChatError(
                    "${output.finishReason} ${output.status['message']}");
              }
            },
          );

          // await emit.forEach(
          //   _serverRepository.sendPromptMessage(prompt),
          //   onData: (PromptOutputModel output) {
          //     messages.add(ChatModel(ChatRole.chatbot, output.promtOutput));
          //     if (output.finishReason == PromptFinishReason.stop) {
          //       return ChatSuccess(messages);
          //     } else {
          //       return ChatError(messages,
          //           output.finishReason.name + output.status['message']);
          //     }
          //   },
          // );

          emit(ChatIdle());
        } catch (e) {
          print(e);
          emit(ChatError(e.toString()));
        }
      },
    );
  }

  @override
  Future<void> close() {
    _chatRepository.disconnect();
    return super.close();
  }

  final ServerRepository _serverRepository;
  final ChatRepository _chatRepository;
}
