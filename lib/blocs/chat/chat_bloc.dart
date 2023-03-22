import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

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
  Stream<PromptOutputModel>? _chatStream;

  ChatBloc(this._serverRepository, this._chatRepository)
      : super(ChatInitial(const [])) {
    on<CreateChatSession>((event, emit) async {
      emit(ChatLoading(state.messages));

      try {
        sessionId = await _serverRepository.createSession(event.domain);
        //Should be changes to sessionId instead of hardcoded.
        await _chatRepository.connect('serach_rows_columns_kekw');
        _chatStream = _chatRepository.receive();
        emit(ChatIdle(state.messages));
      } catch (e) {
        //Log errors
        print(e);
        emit(ChatError("Couldn't establish connection", state.messages));
      }
    });

    on<SendChatMessage>((event, emit) async {
      List<ChatModel> messages = List.from(state.messages)
        ..add(ChatModel(ChatRole.user, event.message));
      emit(ChatLoading(messages));

      //Save message in firebase before
      await _chatRepository.send({'promptInput': event.message});

      var message = '';

      try {
        await emit.forEach(
          _chatStream!,
          onData: (PromptOutputModel output) {
            message += output.promptOutput;
            if (output.finishReason == null) {
              return ChatWriting(message, messages);
            } else if (output.finishReason == PromptFinishReason.stop) {
              return ChatIdle(
                  messages..add(ChatModel(ChatRole.chatbot, message)));
            } else {
              return ChatError(
                  "${output.finishReason} ${output.status['message']}",
                  messages..add(ChatModel(ChatRole.chatbot, message)));
            }
          },
        );

        emit(ChatIdle(messages));
      } catch (e) {
        print(e);
        emit(ChatError(e.toString(), messages));
      }
    }, transformer: restartable());
  }

  @override
  Future<void> close() {
    _chatRepository.disconnect();
    return super.close();
  }

  final ServerRepository _serverRepository;
  final ChatRepository _chatRepository;
}
