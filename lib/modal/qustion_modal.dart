class UserModel {
  String questionId;
  String question;
  String questionDate;
  String questionName;
  String expertiseId;

  UserModel({this.questionId, this.question, this.questionDate, this.questionName, this.expertiseId});

  UserModel.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    question = json['question'];
    questionDate = json['question_date'];
    questionName = json['question_name'];
    expertiseId = json['expertise_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['question'] = this.question;
    data['question_date'] = this.questionDate;
    data['question_name'] = this.questionName;
    data['expertise_id'] = this.expertiseId;
    return data;
  }
}
