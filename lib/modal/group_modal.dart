class GroupSym {
  String groupId;
  String groupName;
  String organId;

  GroupSym({this.groupId, this.groupName, this.organId});

  GroupSym.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupName = json['group_name'];
    organId = json['organ_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['group_name'] = this.groupName;
    data['organ_id'] = this.organId;
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