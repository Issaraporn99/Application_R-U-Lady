class Getdissym {
  String expertiseId;
  String diseaseId;
  String desId;
  String symptomId;
  String groupId;
  String yn;
  String groupName;
  String organId;
  String symptomName;
  String desName;
  String diseaseName;
  String diseaseDetail;
  String diseaseCause;
  String diseaseRisk;
  String diseaseChance;
  String diseaseTreatment;
  String diseaseDefence;
  String diseaseAbout;
  String expertiseName;

  Getdissym(
      {this.expertiseId,
      this.diseaseId,
      this.desId,
      this.symptomId,
      this.groupId,
      this.yn,
      this.groupName,
      this.organId,
      this.symptomName,
      this.desName,
      this.diseaseName,
      this.diseaseDetail,
      this.diseaseCause,
      this.diseaseRisk,
      this.diseaseChance,
      this.diseaseTreatment,
      this.diseaseDefence,
      this.diseaseAbout,
      this.expertiseName});

  Getdissym.fromJson(Map<String, dynamic> json) {
    expertiseId = json['expertise_id'];
    diseaseId = json['disease_id'];
    desId = json['des_id'];
    symptomId = json['symptom_id'];
    groupId = json['group_id'];
    yn = json['yn'];
    groupName = json['group_name'];
    organId = json['organ_id'];
    symptomName = json['symptom_name'];
    desName = json['des_name'];
    diseaseName = json['disease_name'];
    diseaseDetail = json['disease_detail'];
    diseaseCause = json['disease_cause'];
    diseaseRisk = json['disease_risk'];
    diseaseChance = json['disease_chance'];
    diseaseTreatment = json['disease_treatment'];
    diseaseDefence = json['disease_defence'];
    diseaseAbout = json['disease_about'];
    expertiseName = json['expertise_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expertise_id'] = this.expertiseId;
    data['disease_id'] = this.diseaseId;
    data['des_id'] = this.desId;
    data['symptom_id'] = this.symptomId;
    data['group_id'] = this.groupId;
    data['yn'] = this.yn;
    data['group_name'] = this.groupName;
    data['organ_id'] = this.organId;
    data['symptom_name'] = this.symptomName;
    data['des_name'] = this.desName;
    data['disease_name'] = this.diseaseName;
    data['disease_detail'] = this.diseaseDetail;
    data['disease_cause'] = this.diseaseCause;
    data['disease_risk'] = this.diseaseRisk;
    data['disease_chance'] = this.diseaseChance;
    data['disease_treatment'] = this.diseaseTreatment;
    data['disease_defence'] = this.diseaseDefence;
    data['disease_about'] = this.diseaseAbout;
    data['expertise_name'] = this.expertiseName;
    return data;
  }
}
