import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final String? questionId;
  final String? questionName;
  final String? type;
  final List<QuestionEntity>? options;

  const QuestionEntity({
    this.questionId,
    this.questionName,
    this.type,
    this.options,
  });

  @override
  List<Object?> get props => [questionId, questionName, type, options];
}

class OptionEntity extends Equatable {
  final String? optionId;
  final String? optionName;

  const OptionEntity({
    this.optionId,
    this.optionName,
  });

  @override
  List<Object?> get props => [optionId, optionName];
}
