import 'dart:convert';
import 'package:doctorpurin/modal/groupBody.dart';
import 'package:http/http.dart' as http;
import 'package:doctorpurin/modal/disinfo_model.dart';

class Services {
  static const ROOT = 'http://192.168.1.108/apidoctor/disInfo.php?isAdd=true';
  static const String _GET_ACTION = 'true';

  static Future<List<DisInfo>> getDisease() async {
    try {
      var map = new Map<String, dynamic>();
      map["isAdd"] = _GET_ACTION;
      final response = await http.post(ROOT, body: map);
      print("getDisease >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<DisInfo> list = parsePhotos(response.body);
        return list;
      } else {
        throw List<DisInfo>();
      }
    } catch (e) {
      return List<DisInfo>();
    }
  }

  static List<DisInfo> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<DisInfo>((json) => DisInfo.fromJson(json)).toList();
  }
}

class ServicesGroupBody {
  static const ROOT = 'http://192.168.1.108/apidoctor/groupBody.php?isAdd=true&idOrgan=1';
  static const String _GET_ACTION = 'true';

  static Future<List<GroupBody>> getGroupBody() async {
    try {
      var map = new Map<String, dynamic>();
      map["isAdd"] = _GET_ACTION;
      final response = await http.post(ROOT, body: map);
      print("getGroupBody >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<GroupBody> list = parsePhotos(response.body);
        return list;
      } else {
        throw List<GroupBody>();
      }
    } catch (e) {
      return List<GroupBody>();
    }
  }

  static List<GroupBody> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<GroupBody>((json) => GroupBody.fromJson(json)).toList();
  }
}





// Future<Null> readDis() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   String idDisease = preferences.getString('idDisease');

//   String url =
//       'http://192.168.43.187/issaafood/disInfo.php?isAdd=true&idDisease=$idDisease';
//   // await Dio().get(url).then((value) => {print('value = $value')});
//   Response response = await Dio().get(url);
//   print('dis = $response');
//   var result = json.decode(response.data);
//   dis = result;
//   // print(dis);
// }