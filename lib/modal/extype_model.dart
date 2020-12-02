import 'dart:convert';

ExType exTypeFromJson(String str) => ExType.fromJson(json.decode(str));

String exTypeToJson(ExType data) => json.encode(data.toJson());

class ExType {
    ExType({
        this.idType,
        this.nameType,
    });

    String idType;
    String nameType;

    factory ExType.fromJson(Map<String, dynamic> json) => ExType(
        idType: json["idType"] == null ? null : json["idType"],
        nameType: json["nameType"] == null ? null : json["nameType"],
    );

    Map<String, dynamic> toJson() => {
        "idType": idType == null ? null : idType,
        "nameType": nameType == null ? null : nameType,
    };
}








// class ExtypeModel {
//   String idType;
//   String nameType;

//   ExtypeModel({this.idType, this.nameType});

//   ExtypeModel.fromJson(Map<String, dynamic> json) {
//     idType = json['idType'];
//     nameType = json['nameType'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['idType'] = this.idType;
//     data['nameType'] = this.nameType;
//     return data;
//   }
// }