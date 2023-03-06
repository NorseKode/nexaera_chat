import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Should be changed to a bloc
class AuthProvider with ChangeNotifier {
  User? user;
  StreamSubscription? userAuthSub;

  AuthProvider() {
    userAuthSub = FirebaseAuth.instance.userChanges().listen((newUser) {
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

  void signIn(String email, String password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void signUp(String email, String password) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  void signInWithMicrosoft() async {
    final microsoftProvider = MicrosoftAuthProvider();
    //microsoftProvider.setCustomParameters({'response_type': 'code'});

    microsoftProvider.addScope('user.read');
    microsoftProvider.addScope('mail.read');
    microsoftProvider.addScope('mail.send');
    microsoftProvider.addScope('offline_access');

    if (kIsWeb) {
      FirebaseAuth.instance.currentUser
          ?.linkWithPopup(microsoftProvider)
          .then((value) {
        print(value.credential!.asMap().toString());
      });
    } else {
      FirebaseAuth.instance.currentUser
          ?.linkWithPopup(microsoftProvider)
          .then((value) {
        print("");
      });
    }
  }

  void unlinkMicrosoft() async {
    try {
      user?.unlink('microsoft.com').then((value) => print(value));
    } catch (e) {
      print(e);
    }
  }
}
