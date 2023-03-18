import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/authentication_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this._auth) : super(UserInitial()) {
    on<GetUserDetails>((event, emit) async {
      emit(UserLoading());
      try {
        await emit.forEach(_auth.streamUserDetails(event.userId),
            onData: (UserModel? user) => UserLoaded(
                user!.firstName ?? '?', user.lastName ?? '?', user.email));
      } on Exception catch (e) {
        print(e);
        emit(UserError());
      }
    });
  }

  final AuthenticationRepository _auth;
}
