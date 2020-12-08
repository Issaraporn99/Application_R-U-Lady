import 'package:intl/intl.dart';

class ArticleInfo {
  String articlesid;
  String topic;
  String detail;
  String issuedate;
  String id;

  ArticleInfo(
      {this.articlesid, this.topic, this.detail, this.issuedate, this.id});

  ArticleInfo.fromJson(Map<String, dynamic> json) {
    articlesid = json['articles_id'];
    topic = json['topic'];
    detail = json['detail'];
    issuedate = json['issue_date']== null
        ? null
        : DateFormat('วันที่ d MMMM y')
            .format(DateTime.parse(json['date_time']));
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['articles_id'] = this.articlesid;
    data['topic'] = this.topic;
    data['detail'] = this.detail;
    data['issue_date'] = this.issuedate;
    data['id'] = this.id;
    return data;
  }
}