import '../../presentation/constants/promt_finish_reason.dart';

class PromptOutputModel {
  String sessionId;
  String promtOutput;
  Map<String, String> sources;
  Map<String, int> tokenUsage;
  PromptFinishReason finishReason;

  PromptOutputModel(
      {required this.sessionId,
      required this.promtOutput,
      required this.sources,
      required this.tokenUsage,
      required this.finishReason});

  Map<String, dynamic> toMap() {
    return {
      'sessionId': sessionId,
      'PromtOutput': promtOutput,
      'sources': sources,
      'tokenUsage': tokenUsage,
      'finishReason': finishReason
    };
  }

  PromptOutputModel.fromMap(Map<String, dynamic> map)
      : sessionId = map['sessionId'],
        promtOutput = map['PromtOutput'],
        sources = map['sources'],
        tokenUsage = map['tokenUsage'],
        finishReason = map['finishReason'];
}
