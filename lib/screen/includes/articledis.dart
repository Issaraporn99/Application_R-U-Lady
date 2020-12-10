import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/ad.dart';
import 'package:doctorpurin/screen/disease/service.dart';
import 'package:doctorpurin/screen/includes/showad.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NextPage extends StatefulWidget {
  final String value;

  NextPage({Key key, this.value}) : super(key: key);

  @override
  _NextPageState createState() => new _NextPageState();
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

class _NextPageState extends State<NextPage> {
  List<ArticleDisInfo> _article;

  String ida;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _article = [];
    _getArticle2();
    Intl.defaultLocale = "th";
    initializeDateFormatting();
    print(widget.value);
  }

  _getArticle2() {
    ServicesArticle2.getArticle2().then((aa) {
      setState(() {
        _article = aa;
      });

      print("Length: ${aa.length}");
    });
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
          rows: _article
              .map(
                (aa) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        aa.topic,
                        style: TextStyle(fontFamily: 'Prompt'),
                      ),
                      onTap: () {
                        print("name " + aa.topic);
                        ida = aa.articlesId;
                        print(ida);
                        routeTS(ShowAD(), aa);
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
    String articlesid = preferences.getString('articles_id');

    String url =
        'http://10.7.0.80/apidoctor/getArticleWhereId.php?isAdd=true&articles_id=$articlesid';
    await Dio().get(url).then((value) => {print('value = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('res = $result');
      for (var map in result) {
        ArticleDisInfo articleInfo = ArticleDisInfo.fromJson(map);
        if (articlesid == articleInfo.articlesId) {
          routeTS(ShowAD(), articleInfo);
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTS(Widget myWidgett, ArticleDisInfo articleInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('articles_id', articleInfo.articlesId);
    preferences.setString('topic', articleInfo.topic);
    preferences.setString('detail', articleInfo.detail);
    preferences.setString('issue_date', articleInfo.issueDate);
    preferences.setString('id', articleInfo.id);
    preferences.setString('doctorname', articleInfo.diseaseName);
    preferences.setString('disease_id', articleInfo.diseaseId);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    String a = (widget.value);
    print(a);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("บทความที่เกี่ยวข้อง"),
      ),
      // body: new Text("${widget.value}"),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            Expanded(
              child: _dataBody(),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('$a'),
            ),
          ],
        ),
      ),
    );
  }
}
