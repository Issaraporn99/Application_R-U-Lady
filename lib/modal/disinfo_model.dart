class DisInfo {
  String diseaseid;
  String diseasename;
  String diseasedetail;
  String diseasecause;
  String diseaserisk;
  String diseasechance;
  String diseasetreatment;
  String diseasedefence;
  String diseaseabout;
  String expertiseid;
  String expertisename;

  DisInfo(
      {this.diseaseid,
      this.diseasename,
      this.diseasedetail,
      this.diseasecause,
      this.diseaserisk,
      this.diseasechance,
      this.diseasetreatment,
      this.diseasedefence,
      this.diseaseabout,
      this.expertiseid,
      this.expertisename});

  factory DisInfo.fromJson(Map<String, dynamic> json) {
    return DisInfo(
      diseaseid: json['disease_id'] as String,
      diseasename: json['disease_name'] as String,
      diseasedetail: json['disease_detail'] as String,
      diseasecause: json['disease_cause'] as String,
      diseaserisk: json['disease_risk'] as String,
      diseasechance: json['disease_chance'] as String,
      diseasetreatment: json['disease_treatment'] as String,
      diseasedefence: json['disease_defence'] as String,
      diseaseabout: json['disease_about'] as String,
      expertiseid: json['expertise_id'] as String,
      expertisename: json['expertise_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disease_id'] = this.diseaseid;
    data['disease_name'] = this.diseasename;
    data['disease_detail'] = this.diseasedetail;
    data['disease_cause'] = this.diseasecause;
    data['disease_risk'] = this.diseaserisk;
    data['disease_chance'] = this.diseasechance;
    data['disease_treatment'] = this.diseasetreatment;
    data['disease_defence'] = this.diseasedefence;
    data['disease_about'] = this.diseaseabout;
    data['expertise_id'] = this.expertiseid;
    data['expertise_name'] = this.expertisename;
    return data;
  }
}
