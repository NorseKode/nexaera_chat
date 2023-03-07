import 'package:cloud_firestore/cloud_firestore.dart';

class DomainModel {
  String? uid;
  String domain;

  DomainModel({this.uid, required this.domain});

  Map<String, dynamic> toMap() {
    return {'domain': domain};
  }

  DomainModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        domain = doc.data()!["domain"];

  DomainModel copyWith({String? uid, String? domain}) {
    return DomainModel(uid: uid ?? this.uid, domain: domain ?? this.domain);
  }
}
