class GroupSym {
  String groupId;
  String groupName;
  String organId;
  String symptomId;
  String symptomName;

  String diseaseId;

  GroupSym({this.groupId, this.groupName, this.organId});

  GroupSym.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupName = json['group_name'];
    organId = json['organ_id'];
    symptomId = json['symptom_id'];
    symptomName = json['symptom_name'];

    diseaseId = json['disease_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['group_name'] = this.groupName;
    data['organ_id'] = this.organId;
    data['symptom_id'] = this.symptomId;
    data['symptom_name'] = this.symptomName;
    data['disease_id'] = this.diseaseId;
    return data;
  }
}

// Future<Null> findId() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   setState(() {
//     organId = preferences.getString('organ_id');
//     groupName = preferences.getString('group_name');
//     groupId = preferences.getString('group_id');
//   });
// }
