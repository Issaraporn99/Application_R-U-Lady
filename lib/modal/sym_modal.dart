class SymModal {
  String symptomId;
  String symptomName;
  String groupId;
  String diseaseId;

  SymModal({this.symptomId, this.symptomName, this.groupId, this.diseaseId});

  SymModal.fromJson(Map<String, dynamic> json) {
    symptomId = json['symptom_id'];
    symptomName = json['symptom_name'];
    groupId = json['group_id'];
    diseaseId = json['disease_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symptom_id'] = this.symptomId;
    data['symptom_name'] = this.symptomName;
    data['group_id'] = this.groupId;
    data['disease_id'] = this.diseaseId;
    return data;
  }
}