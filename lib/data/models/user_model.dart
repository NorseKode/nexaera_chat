import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  bool? isVerified;
  final String? email;
  final String? firstName;
  final String? lastName;
  UserModel(
      {this.uid, this.email, this.firstName, this.lastName, this.isVerified});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'is_verified': isVerified ?? false,
      'company': ''
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        email = doc.data()!["email"],
        firstName = doc.data()!["first_name"],
        lastName = doc.data()!["last_name"],
        isVerified = doc.data()!["is_verified"];

  UserModel copyWith(
      {bool? isVerified,
      String? uid,
      String? email,
      String? password,
      String? displayName}) {
    return UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        firstName: displayName ?? this.firstName,
        isVerified: isVerified ?? this.isVerified);
  }
}
