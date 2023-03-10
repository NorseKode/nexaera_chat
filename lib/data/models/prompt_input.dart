class PromptInputModel {
  String sessionId;
  String message;

  PromptInputModel({required this.sessionId, required this.message});

  Map<String, dynamic> toMap() {
    return {'sessionId': sessionId, 'promtInput': message};
  }

  PromptInputModel.fromMap(Map<String, dynamic> map)
      : sessionId = map['sessionId'],
        message = map['promtInput'];

  PromptInputModel copyWith(
      {String? sessionId, String? promtInput, String? clientId}) {
    return PromptInputModel(
        sessionId: sessionId ?? this.sessionId,
        message: promtInput ?? this.message);
  }
}
