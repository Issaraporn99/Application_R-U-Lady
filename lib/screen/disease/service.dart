import 'dart:convert';
import 'package:doctorpurin/modal/ad.dart';
import 'package:doctorpurin/modal/article_modal.dart';
import 'package:doctorpurin/modal/question_modal.dart';
import 'package:http/http.dart' as http;
import 'package:doctorpurin/modal/disinfo_model.dart';

class Services {
  static const ROOT =
      'http://student.crru.ac.th/601463046/apidoctor/disInfo.php?isAdd=true';
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

class ServicesArticle {
  static const ROOT =
      'http://student.crru.ac.th/601463046/apidoctor/getArticle.php?isAdd=true';
  static const String _GET_ACTION = 'true';

  static Future<List<ArticleInfo>> getArticle() async {
    try {
      var map = new Map<String, dynamic>();
      map["isAdd"] = _GET_ACTION;
      final response = await http.post(ROOT, body: map);
      print("getArticle >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<ArticleInfo> list = parsePhotos(response.body);
        return list;
      } else {
        throw List<ArticleInfo>();
      }
    } catch (e) {
      return List<ArticleInfo>();
    }
  }

  static List<ArticleInfo> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ArticleInfo>((json) => ArticleInfo.fromJson(json))
        .toList();
  }
}

class ServicesArticle2 {
  static const ROOT =
      'http://student.crru.ac.th/601463046/apidoctor/getArticleDis.php?disease_id=1&isAdd=true';
  static const String _GET_ACTION = 'true';

  static Future<List<ArticleDisInfo>> getArticle2() async {
    try {
      var map = new Map<String, dynamic>();
      map["isAdd"] = _GET_ACTION;
      final response = await http.post(ROOT, body: map);
      print("getArticle2 >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<ArticleDisInfo> list = parsePhotos(response.body);
        return list;
      } else {
        throw List<ArticleDisInfo>();
      }
    } catch (e) {
      return List<ArticleDisInfo>();
    }
  }

  static List<ArticleDisInfo> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ArticleDisInfo>((json) => ArticleDisInfo.fromJson(json))
        .toList();
  }
}

class ServicesQA {
  static const ROOT = 'http://student.crru.ac.th/601463046/apidoctor/getQ.php?isAdd=true';
  static const String _GET_ACTION = 'true';

  static Future<List<Question>> getQ() async {
    try {
      var map = new Map<String, dynamic>();
      map["isAdd"] = _GET_ACTION;
      final response = await http.post(ROOT, body: map);
      print("getDisease >> Response:: ${response.body}");
      if (response.statusCode == 200) {
        List<Question> list = parsePhotos(response.body);
        return list;
      } else {
        throw List<Question>();
      }
    } catch (e) {
      return List<Question>();
    }
  }

  static List<Question> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Question>((json) => Question.fromJson(json)).toList();
  }
}
