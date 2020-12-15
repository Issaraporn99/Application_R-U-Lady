import 'package:intl/intl.dart';

class Question {
  String questionId;
  String question;
  String questionDate;
  String questionName;
  String expertiseId;

  Question(
      {this.questionId,
      this.question,
      this.questionDate,
      this.questionName,
      this.expertiseId});

  Question.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    question = json['question'];
    questionDate = json['question_date']== null
        ? null
        : DateFormat('d/MM/y')
            .format(DateTime.parse(json['question_date']));
    questionName = json['question_name'];
    expertiseId = json['expertise_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['question'] = this.question;
    data['question_date'] = this.questionDate;
    data['question_name'] = this.questionName;
    data['expertise_id'] = this.expertiseId;
    return data;
  }
}