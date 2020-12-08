class ArticleDisInfo {
  String articlesId;
  String diseaseId;
  String diseaseName;
  String diseaseDetail;
  String diseaseCause;
  String diseaseRisk;
  String diseaseChance;
  String diseaseTreatment;
  String diseaseDefence;
  String diseaseAbout;
  String expertiseId;
  String topic;
  String detail;
  String issueDate;
  String id;

  ArticleDisInfo(
      {this.articlesId,
      this.diseaseId,
      this.diseaseName,
      this.diseaseDetail,
      this.diseaseCause,
      this.diseaseRisk,
      this.diseaseChance,
      this.diseaseTreatment,
      this.diseaseDefence,
      this.diseaseAbout,
      this.expertiseId,
      this.topic,
      this.detail,
      this.issueDate,
      this.id});

  ArticleDisInfo.fromJson(Map<String, dynamic> json) {
    articlesId = json['articles_id'];
    diseaseId = json['disease_id'];
    diseaseName = json['disease_name'];
    diseaseDetail = json['disease_detail'];
    diseaseCause = json['disease_cause'];
    diseaseRisk = json['disease_risk'];
    diseaseChance = json['disease_chance'];
    diseaseTreatment = json['disease_treatment'];
    diseaseDefence = json['disease_defence'];
    diseaseAbout = json['disease_about'];
    expertiseId = json['expertise_id'];
    topic = json['topic'];
    detail = json['detail'];
    issueDate = json['issue_date'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['articles_id'] = this.articlesId;
    data['disease_id'] = this.diseaseId;
    data['disease_name'] = this.diseaseName;
    data['disease_detail'] = this.diseaseDetail;
    data['disease_cause'] = this.diseaseCause;
    data['disease_risk'] = this.diseaseRisk;
    data['disease_chance'] = this.diseaseChance;
    data['disease_treatment'] = this.diseaseTreatment;
    data['disease_defence'] = this.diseaseDefence;
    data['disease_about'] = this.diseaseAbout;
    data['expertise_id'] = this.expertiseId;
    data['topic'] = this.topic;
    data['detail'] = this.detail;
    data['issue_date'] = this.issueDate;
    data['id'] = this.id;
    return data;
  }
}
