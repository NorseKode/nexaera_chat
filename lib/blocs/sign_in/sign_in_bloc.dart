import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../app/auth.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthProvider _auth;
  SignInBloc(this._auth) : super(SignInInitial()) {
    on<SigningIn>((event, emit) async {
      emit(SignInLoading());
      await _auth.signIn(event.email, event.password);
      emit(SignInInitial());
    });
  }
}
