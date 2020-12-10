import 'package:intl/intl.dart';

class ArticleDisInfo {
  String diseaseId;
  String articlesId;
  String topic;
  String detail;
  String issueDate;
  String id;
  String diseaseName;
  String doctorname;


  ArticleDisInfo({
    this.diseaseId,
    this.articlesId,
    this.topic,
    this.detail,
    this.issueDate,
    this.id,
    this.diseaseName,
    this.doctorname,
  });

  factory ArticleDisInfo.fromJson(Map<String, dynamic> json) {
    return ArticleDisInfo(
      diseaseId: json['disease_id'] as String,
      articlesId: json['articles_id'] as String,
      detail: json['detail'] as String,
      topic: json['topic'] as String,
      issueDate: json['issue_date'] == null
          ? null
          : DateFormat('วันที่ d MMMM y')
              .format(DateTime.parse(json['issue_date'])),
      id: json['id'] as String,
      diseaseName: json['diseaseName'] as String,
      doctorname: json['doctorname'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disease_id'] = this.diseaseId;
    data['articles_id'] = this.articlesId;
    data['topic'] = this.topic;
    data['detail'] = this.detail;
    data['issue_date'] = this.issueDate;
    data['id'] = this.id;
    data['disease_name'] = this.diseaseName;
    data['doctorname'] = this.doctorname;
    return data;
  }
}
