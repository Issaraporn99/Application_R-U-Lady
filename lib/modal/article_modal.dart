import 'package:intl/intl.dart';
class ArticleInfo {
  String articlesid;
  String topic;
  String detail;
  String issuedate;
  String id;
  String username;
  String password;
  String doctorname;
  String office;
  String userlevel;
  String expertiseId;

  ArticleInfo(
      {this.articlesid,
      this.topic,
      this.detail,
      this.issuedate,
      this.id,
      this.username,
      this.password,
      this.doctorname,
      this.office,
      this.userlevel,
      this.expertiseId});

 factory ArticleInfo.fromJson(Map<String, dynamic> json) {
    return ArticleInfo(
      articlesid: json['articles_id'] as String,
      topic: json['topic'] as String,
      detail: json['detail'] as String,
          issuedate : json['issue_date']== null
        ? null
        : DateFormat('วันที่ d MMMM y')
            .format(DateTime.parse(json['issue_date'])),
      id: json['id'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      doctorname: json['doctorname'] as String,
      office: json['office'] as String,
      userlevel: json['userlevel'] as String,
      expertiseId: json['expertiseId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['articles_id'] = this.articlesid;
    data['topic'] = this.topic;
    data['detail'] = this.detail;
    data['issue_date'] = this.issuedate;
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['doctorname'] = this.doctorname;
    data['office'] = this.office;
    data['userlevel'] = this.userlevel;
    data['expertise_id'] = this.expertiseId;
    return data;
  }
}