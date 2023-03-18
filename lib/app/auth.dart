import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexaera_chat/data/models/user_model.dart';
import 'package:nexaera_chat/data/repositories/authentication_repository.dart';
import 'package:nexaera_chat/data/services/firestore_service.dart';

import '../data/services/auth_service.dart';

//Should be changed to a bloc
class AuthProvider with ChangeNotifier {
  User? user;
  final AuthenticationRepository _auth;
  StreamSubscription? userAuthSub;

  AuthProvider(this._auth) {
    userAuthSub = _auth.retrieveCurrentUser().listen((newUser) {
      user = newUser;
      notifyListeners();
    }, onError: (e) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
  }

  @override
  void dispose() {
    if (userAuthSub != null) {
      userAuthSub!.cancel();
      userAuthSub = null;
    }
    super.dispose();
  }

  bool get isAuthenticated {
    return user != null;
  }

  Future<UserModel> getCurrentUserDetails() async {
    return await _auth.getUserDetails(user!.uid);
  }

  Future<UserCredential?> signIn(String email, String password) async {
    return _auth.signIn(email, password);
  }

  Future signOut() async {
    _auth.signOut();
  }

  Future signUp(String email, String password) async {
    _auth.signUp(email, password);
  }

  Future updateUserInfo(String firstName, String lastName) async {
    _auth.updateUserInfo(user!.uid, firstName, lastName);
  }
}
