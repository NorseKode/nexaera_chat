import 'dart:io';

class ScrapeProgressModel {
  HttpStatus status;
  String urlInProgress;

  ScrapeProgressModel({required this.status, required this.urlInProgress});

  Map<String, dynamic> toMap() {
    return {'status': status, 'urlInProgress': urlInProgress};
  }

  ScrapeProgressModel.fromMap(Map<String, dynamic> map)
      : status = map['status'],
        urlInProgress = map['urlInProgress'];
}
