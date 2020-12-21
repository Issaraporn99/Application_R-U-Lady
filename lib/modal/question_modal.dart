import 'package:intl/intl.dart';
// class Question {
//   String questionId;
//   String question;
//   String questionDate;
//   String questionName;
//   String expertiseId;
//   String answerId;
//   String answerName;
//   String answerDate;
//   String id;

//   Question(
//       {this.questionId,
//       this.question,
//       this.questionDate,
//       this.questionName,
//       this.expertiseId,
//       this.answerId,
//       this.answerName,
//       this.answerDate,
//       this.id});

//   Question.fromJson(Map<String, dynamic> json) {
//     questionId = json['question_id'];
//     question = json['question'];
//     questionDate = json['question_date'] == null
//         ? null
//         : DateFormat('d/MM/y').format(DateTime.parse(json['question_date']));
//     questionName = json['question_name'];
//     expertiseId = json['expertise_id'];
//     answerId = json['answer_id'];
//     answerName = json['answer_name'];
//     answerDate = json['answer_date'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['question_id'] = this.questionId;
//     data['question'] = this.question;
//     data['question_date'] = this.questionDate;
//     data['question_name'] = this.questionName;
//     data['expertise_id'] = this.expertiseId;
//     data['answer_id'] = this.answerId;
//     data['answer_name'] = this.answerName;
//     data['answer_date'] = this.answerDate;
//     data['id'] = this.id;
//     return data;
//   }
// }
class Question {
  String questionId;
  String question;
  String questionDate;
  String questionName;
  String expertiseId;
  String answerId;
  String answerName;
  String answerDate;
  String id;
  String username;
  String password;
  String doctorname;
  String office;
  String userlevel;

  Question(
      {this.questionId,
      this.question,
      this.questionDate,
      this.questionName,
      this.expertiseId,
      this.answerId,
      this.answerName,
      this.answerDate,
      this.id,
      this.username,
      this.password,
      this.doctorname,
      this.office,
      this.userlevel});

  Question.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    question = json['question'];
    questionDate = json['question_date'] == null
         ? null
         : DateFormat('d/MM/y').format(DateTime.parse(json['question_date']));
    questionName = json['question_name'];
    expertiseId = json['expertise_id'];
    answerId = json['answer_id'];
    answerName = json['answer_name'];
    answerDate = json['answer_date'];
    id = json['id'];
    username = json['username'];
    password = json['password'];
    doctorname = json['doctorname'];
    office = json['office'];
    userlevel = json['userlevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['question'] = this.question;
    data['question_date'] = this.questionDate;
    data['question_name'] = this.questionName;
    data['expertise_id'] = this.expertiseId;
    data['answer_id'] = this.answerId;
    data['answer_name'] = this.answerName;
    data['answer_date'] = this.answerDate;
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['doctorname'] = this.doctorname;
    data['office'] = this.office;
    data['userlevel'] = this.userlevel;
    return data;
  }
}