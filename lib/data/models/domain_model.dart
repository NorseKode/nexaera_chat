import 'package:cloud_firestore/cloud_firestore.dart';

class DomainModel {
  String? uid;
  String domain;
  List<String> altDomains;

  DomainModel({this.uid, required this.domain, required this.altDomains});

  Map<String, dynamic> toMap() {
    return {'domain': domain, 'alt_domains': altDomains};
  }

  DomainModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        domain = doc.data()!["domain"],
        altDomains = doc.data()!["alt_domains"];

  DomainModel copyWith(
      {String? uid, String? domain, List<String>? altDomains}) {
    return DomainModel(
        uid: uid ?? this.uid,
        domain: domain ?? this.domain,
        altDomains: altDomains ?? this.altDomains);
  }
}
