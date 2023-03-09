import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nexaera_chat/data/services/firestore_service.dart';

import '../../data/services/authorization_service.dart';

//Should be changed to a bloc
class AuthProvider with ChangeNotifier {
  User? user;
  AuthenticationService _auth;
  FirestoreService _firestoreService;
  StreamSubscription? userAuthSub;

  AuthProvider(this._auth, this._firestoreService) {
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

  Future getCurrentUserDetails() async {
    return await _firestoreService.getDocument('users', user!.uid);
  }

  Future signIn(String email, String password) async {
    _auth.signIn(email, password);
  }

  Future signOut() async {
    _auth.signOut();
  }

  Future signUp(String email, String password) async {
    _auth.signUp(email, password);
  }
}
