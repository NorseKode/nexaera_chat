import '../../presentation/constants/promt_finish_reason.dart';

class PromptOutputModel {
  String promptOutput;
  Map<String, String> sources;
  Map<String, int> tokenUsage;
  PromptFinishReason? finishReason;
  Map<String, String> status;

  PromptOutputModel(
      {required this.promptOutput,
      required this.sources,
      required this.tokenUsage,
      required this.finishReason,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'promptOutput': promptOutput,
      'sources': sources,
      'tokenUsage': tokenUsage,
      'finishReason': finishReason,
      'status': status
    };
  }

  PromptOutputModel.fromMap(Map<String, dynamic> map)
      : promptOutput = map['promptOutput'],
        sources = map['sources'],
        tokenUsage = map['tokenUsage'],
        finishReason = map['finishReason'],
        status = map['status'];
}
