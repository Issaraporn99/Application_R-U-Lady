class ArticleInfo {
  String articlesid;
  String topic;
  String detail;
  DateTime issuedate;
  String id;

  ArticleInfo(
      {this.articlesid,
      this.topic,
      this.detail,
      this.issuedate,
      this.id});

  factory ArticleInfo.fromJson(Map<String, dynamic> json) {
    return ArticleInfo(
      articlesid: json['articles_id'] as String,
      topic: json['topic'] as String,
      detail: json['detail'] as String,
      issuedate: json['issuedate'] as DateTime,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['articles_id'] = this.articlesid;
    data['topic'] = this.topic;
    data['detail'] = this.detail;
    data['issuedate'] = this.issuedate;
    data['id'] = this.id;
    return data;
  }
}
