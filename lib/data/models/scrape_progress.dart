import 'dart:io';

class ScrapeProgressModel {
  int statusCode;
  String message;
  String urlInProgress;

  ScrapeProgressModel(
      {required this.statusCode,
      required this.message,
      required this.urlInProgress});

  Map<String, dynamic> toMap() {
    return {
      'status': {'code': statusCode, 'message': message},
      'urlInProgress': urlInProgress
    };
  }

  ScrapeProgressModel.fromMap(Map<String, dynamic> map)
      : statusCode = map['status']['code'],
        message = map['status']['message'],
        urlInProgress = map['urlInProgress'];
}
