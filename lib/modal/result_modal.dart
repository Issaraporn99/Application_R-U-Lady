class Getdissym {
  String diseaseId;
  String symptomId;
  String status;
  String yn;
  String symptomName;
  String groupId;
  String diseaseName;
  String diseaseDetail;
  String diseaseCause;
  String diseaseRisk;
  String diseaseChance;
  String diseaseTreatment;
  String diseaseDefence;
  String diseaseAbout;
  String expertiseId;
  String expertiseName;

  Getdissym(
      {this.diseaseId,
      this.symptomId,
      this.status,
      this.yn,
      this.symptomName,
      this.groupId,
      this.diseaseName,
      this.diseaseDetail,
      this.diseaseCause,
      this.diseaseRisk,
      this.diseaseChance,
      this.diseaseTreatment,
      this.diseaseDefence,
      this.diseaseAbout,
      this.expertiseId,
      this.expertiseName});

  Getdissym.fromJson(Map<String, dynamic> json) {
    diseaseId = json['disease_id'];
    symptomId = json['symptom_id'];
    status = json['status'];
    yn = json['yn'];
    symptomName = json['symptom_name'];
    groupId = json['group_id'];
    diseaseName = json['disease_name'];
    diseaseDetail = json['disease_detail'];
    diseaseCause = json['disease_cause'];
    diseaseRisk = json['disease_risk'];
    diseaseChance = json['disease_chance'];
    diseaseTreatment = json['disease_treatment'];
    diseaseDefence = json['disease_defence'];
    diseaseAbout = json['disease_about'];
    expertiseId = json['expertise_id'];
    expertiseName = json['expertise_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disease_id'] = this.diseaseId;
    data['symptom_id'] = this.symptomId;
    data['status'] = this.status;
    data['yn'] = this.yn;
    data['symptom_name'] = this.symptomName;
    data['group_id'] = this.groupId;
    data['disease_name'] = this.diseaseName;
    data['disease_detail'] = this.diseaseDetail;
    data['disease_cause'] = this.diseaseCause;
    data['disease_risk'] = this.diseaseRisk;
    data['disease_chance'] = this.diseaseChance;
    data['disease_treatment'] = this.diseaseTreatment;
    data['disease_defence'] = this.diseaseDefence;
    data['disease_about'] = this.diseaseAbout;
    data['expertise_id'] = this.expertiseId;
    data['expertise_name'] = this.expertiseName;
    return data;
  }
}
