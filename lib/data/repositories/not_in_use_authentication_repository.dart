// import 'package:firebase_auth/firebase_auth.dart';

// import '../models/user_model.dart';
// import '../services/authorization_service.dart';

// class AuthenticationRepository {
//   AuthenticationService service = AuthenticationService();

//   Stream<UserModel> getCurrentUser() {
//     return service.retrieveCurrentUser();
//   }

//   Future<UserCredential?> signUp(UserModel user) {
//     try {
//       return service.signUp(user);
//     } on FirebaseAuthException catch (e) {
//       throw FirebaseAuthException(code: e.code, message: e.message);
//     }
//   }

//   Future<UserCredential?> signIn(UserModel user) {
//     try {
//       return service.signIn(user);
//     } on FirebaseAuthException catch (e) {
//       throw FirebaseAuthException(code: e.code, message: e.message);
//     }
//   }

//   Future<void> signOut() {
//     return service.signOut();
//   }
// }
