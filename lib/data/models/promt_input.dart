class PromtInputModel {
  String sessionId;
  String promtInput;

  PromtInputModel({required this.sessionId, required this.promtInput});

  Map<String, dynamic> toMap() {
    return {'sessionId': sessionId, 'promtInput': promtInput};
  }

  PromtInputModel.fromMap(Map<String, dynamic> map)
      : sessionId = map['sessionId'],
        promtInput = map['promtInput'];

  PromtInputModel copyWith(
      {String? sessionId, String? promtInput, String? clientId}) {
    return PromtInputModel(
        sessionId: sessionId ?? this.sessionId,
        promtInput: promtInput ?? this.promtInput);
  }
}
