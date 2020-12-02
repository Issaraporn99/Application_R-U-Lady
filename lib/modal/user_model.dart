class UserModel {
  String id;
  String chooseType;
  String name;
  String place;
  String user;
  String password;

  UserModel({this.id, this.chooseType, this.name,this.place, this.user, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chooseType = json['ChooseType'];
    name = json['Name'];
    place = json['Place'];
    user = json['User'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ChooseType'] = this.chooseType;
    data['Name'] = this.name;
    data['Place'] = this.place;
    data['User'] = this.user;
    data['Password'] = this.password;
    return data;
  }
}
