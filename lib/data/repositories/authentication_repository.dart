import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

class AuthenticationRepository {
  final AuthenticationService _auth;
  final FirestoreService _firestoreService;

  AuthenticationRepository(this._auth, this._firestoreService);

  Stream<User?> retrieveCurrentUser() {
    return _auth.retrieveCurrentUser().asBroadcastStream();
  }

  Future<UserModel> getCurrentUserDetails(String userId) async {
    try {
      print(userId);
      return await _firestoreService
          .getDocument('users', userId)
          .then((doc) => UserModel.fromDocumentSnapshot(doc));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> createUserDocument(User user) async {
    //match id or email?
    await _firestoreService.createDocument('users', user.uid,
        UserModel(email: user.email, firstName: null, lastName: null).toMap());
  }

  Future<void> updateUserInfo(
      String userId, String firstName, String lastName) async {
    await _firestoreService.updateDocument(
        'users', userId, {'first_name': firstName, 'last_name': lastName});
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await _auth.signIn(email, password);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      var user = await _auth.signUp(email, password);
      await createUserDocument(
        user!.user!,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }
}
