import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/ad.dart';
import 'package:doctorpurin/screen/includes/showArticle.dart';
import 'package:doctorpurin/screen/includes/showad.dart';
import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NextPage extends StatefulWidget {
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
  // List<ArticleDisInfo> _article;
  String diseaseId;
  String ida;
  String topic;
  String diseaseName;
  List<ArticleDisInfo> articleD = List();
  ScrollController _arrowsController = ScrollController();
  @override
  void initState() {
    super.initState();
    // _article = [];
    // _getArticle2();
    Intl.defaultLocale = "th";
    initializeDateFormatting();
    findId();
  }

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      diseaseId = preferences.getString('disease_id');
      diseaseName = preferences.getString('disease_name');
      checkid();
    });
  }

  Future<Null> checkid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    diseaseId = preferences.getString('disease_id');
    diseaseName = preferences.getString('disease_name');
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getArticleDis.php?disease_id=$diseaseId&isAdd=true';
    Response response = await Dio().get(url);
    print('resrr = $response');

    var result = json.decode(response.data);
    print('res = $result');
    for (var map in result) {
      ArticleDisInfo articleInfo = ArticleDisInfo.fromJson(map);
      setState(() {
        articleD.add(articleInfo);
      });
    }
  }

  Future<Null> showGetArticle() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String articlesId = preferences.getString('articles_id');

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getArticleWhereId.php?isAdd=true&articles_id=$articlesId';
    await Dio().get(url).then((value) => {print('value = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('resss = $result');
      for (var map in result) {
        ArticleDisInfo articleInfo = ArticleDisInfo.fromJson(map);
        if (articlesId == articleInfo.articlesId) {
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
    preferences.setString('doctorname', articleInfo.doctorname);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
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
                "บทความเกี่ยวกับโรค " + '$diseaseName',
                style: TextStyle(fontFamily: 'Prompt', fontSize: 16),
              ),
            ),
          ],
          rows: articleD
              .map(
                (article) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        article.topic,
                        style: TextStyle(fontFamily: 'Prompt'),
                      ),
                      onTap: () {
                        print("name " + article.topic);
                        ida = article.articlesId;
                        print(ida);
                        routeTS(ShowAD(), article);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Text(
              'บทความ',
              style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
            )),
            Image.asset(
              './images/Untitled-1.png',
              height: 40,
            ),
          ],
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "บทความเกี่ยวกับโรค " + '$diseaseName',
                style: TextStyle(fontFamily: 'Prompt', fontSize: 16),
              ),
            ),
            // Expanded(
            //   child: _dataBody(),
            // ),
            Expanded(
              child: DraggableScrollbar.arrows(
                alwaysVisibleScrollThumb: true,
                controller: _arrowsController,
                padding: EdgeInsets.only(right: 4.0),
                backgroundColor: Colors.pink[200],
                child: ListView.builder(
                  controller: _arrowsController,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: articleD.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple[100].withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ]),
                      child: ButtonTheme(
                        minWidth: 500.0,
                        height: 50.0,
                        child: FlatButton(
                          color: Colors.white,
                          onPressed: () {
                            routeTS(ShowArticle(), articleD[index]);
                          },
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(articleD[index].topic,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'Prompt',
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                LineIcons.angle_right,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
