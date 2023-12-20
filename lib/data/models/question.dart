import 'package:synapsis_survey_app/domain/entities/question.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel(
      {String? questionId,
      String? questionName,
      String? type,
      List<QuestionEntity>? options})
      : super(
          questionId: questionId,
          questionName: questionName,
          type: type,
          options: options,
        );

  factory QuestionModel.fromJson(Map<String, dynamic> map) {
    return QuestionModel(
      questionId: map['questionid'] ?? "",
      questionName: map['question_name'] ?? "",
      type: map['type'] ?? "",
      options: map['options'] != null
          ? List<QuestionEntity>.from(
              map['options']?.map((x) => OptionModel.fromJson(x)))
          : [],
    );
  }
}

class OptionModel extends OptionEntity {
  const OptionModel({
    String? optionId,
    String? optionName,
  }) : super(
          optionId: optionId,
          optionName: optionName,
        );

  factory OptionModel.fromJson(Map<String, dynamic> map) {
    return OptionModel(
      optionId: map['optionid'] ?? "",
      optionName: map['option_name'] ?? "",
    );
  }
}
