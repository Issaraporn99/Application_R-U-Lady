class GroupSym {
  String groupId;
  String groupName;
  String organId;
  String organName;
  String symptomId;
  String symptomName;
  String desId;
  String desName;
  String diseaseId;
  String yn;

  GroupSym({this.groupId, this.groupName, this.organId});

  GroupSym.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupName = json['group_name'];
    organId = json['organ_id'];
    organName = json['organ_name'];
    symptomId = json['symptom_id'];
    symptomName = json['symptom_name'];
    desId = json['des_id'];
    desName = json['des_name'];
    diseaseId = json['disease_id'];
    yn = json['yn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['group_name'] = this.groupName;
    data['organ_id'] = this.organId;
    data['organ_name'] = this.organName;
    data['symptom_id'] = this.symptomId;
    data['symptom_name'] = this.symptomName;
    data['des_id'] = this.desId;
    data['des_name'] = this.desName;
    data['disease_id'] = this.diseaseId;
    data['yn'] = this.yn;
    return data;
  }
}
