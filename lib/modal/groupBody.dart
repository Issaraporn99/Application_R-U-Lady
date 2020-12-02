class GroupBody {
  String idOrgan;
  String nameOrgan;

  GroupBody({this.idOrgan, this.nameOrgan});

  GroupBody.fromJson(Map<String, dynamic> json) {
    idOrgan = json['idOrgan'];
    nameOrgan = json['nameOrgan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idOrgan'] = this.idOrgan;
    data['nameOrgan'] = this.nameOrgan;
    return data;
  }
}