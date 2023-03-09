import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../authentication/auth.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthProvider _auth;
  SignUpBloc(this._auth) : super(SignUpInitial()) {
    on<SigningUp>((event, emit) async {
      emit(SignUpLoading());
      await _auth.signUp(event.email, event.password);
      emit(SignUpInitial());
    });
  }
}
