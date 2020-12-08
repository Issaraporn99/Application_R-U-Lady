import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/ad.dart';
import 'package:doctorpurin/screen/disease/service.dart';
import 'package:doctorpurin/screen/includes/showArticle.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleDis extends StatefulWidget {
  ArticleDis() : super();

  final String title = "ค้นหาข้อมูลบทความ";
  @override
  _ArticleDisState createState() => _ArticleDisState();
}
class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer
          .cancel(); // when the user is continuosly typing, this cancels the timer
    }
    // then we will start a new timer looking for the user to stop
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
class _ArticleDisState extends State<ArticleDis> {
  List<ArticleDisInfo> _article2;
  List<ArticleDisInfo> _filterarticle2;

  String ida;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
     _article2 = [];
    _filterarticle2 = [];
    _getArticle2();
  }
  _getArticle2() {
    ServicesArticle2.getArticle2().then((articles) {
      setState(() {
      _article2 = articles;
      _filterarticle2 = articles;
      });

      print("Length: ${articles.length}");
    });
  }
  searchField() {
    return Padding(
      padding: EdgeInsets.only(left: 10.0,right: 10.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(1.0),
          hintText: 'ค้นหาบทความ',
        ),
        onChanged: (string) {
          // We will start filtering when the user types in the textfield.
          // Run the debouncer and start searching
          _debouncer.run(() {
            // Filter the original List and update the Filter list
            setState(() {
              _filterarticle2 = _article2
                  .where((u) => (u.topic
                          .toLowerCase()
                          .contains(string.toLowerCase()) ||
                      u.articlesId.toLowerCase().contains(string.toLowerCase())))
                  .toList();
            });
          });
        },
      ),
    );
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                "บทความ",
                style: TextStyle(fontFamily: 'Prompt'),
              ),
            ),
          ],
          rows: _filterarticle2
              .map(
                (articles) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        articles.topic,
                        style: TextStyle(fontFamily: 'Prompt'),
                      ),
                      onTap: () {
                        print("name " + articles.diseaseId);
                        ida = articles.diseaseId;
                        print(ida);
                        routeTS(ShowArticle(), articles);
                      },
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
    Future<Null> showGetArticle() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String diseaseId = preferences.getString('disease_id');

    String url =
        'http://10.4.14.43/apidoctor/getArticleDis.php?isAdd=true&disease_id=11';
    await Dio().get(url).then((value) => {print('value = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('res = $result');
      for (var map in result) {
        ArticleDisInfo articleDisInfo = ArticleDisInfo.fromJson(map);
        if (diseaseId == articleDisInfo.articlesId) {
          routeTS(ShowArticle(), articleDisInfo);
        }
      }
    } catch (e) {}
  }
    Future<Null> routeTS(Widget myWidgett, ArticleDisInfo articleDisInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('articles_id', articleDisInfo.articlesId);
    preferences.setString('topic', articleDisInfo.topic);
    preferences.setString('detail', articleDisInfo.detail);
    preferences.setString('issuedate', articleDisInfo.issueDate);
    preferences.setString('id', articleDisInfo.id);
    preferences.setString('disease_id', articleDisInfo.diseaseId);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
  }
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหาบทความ'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: searchField(),
            ),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
    );
  }
}
