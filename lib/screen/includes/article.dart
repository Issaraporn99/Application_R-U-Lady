import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/article_modal.dart';
import 'package:doctorpurin/screen/disease/service.dart';
import 'package:doctorpurin/screen/includes/showArticle.dart';
import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Article extends StatefulWidget {
  Article() : super();

  final String title = "ค้นหาข้อมูลบทความ";
  @override
  _ArticleState createState() => _ArticleState();
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

class _ArticleState extends State<Article> {
  List<ArticleInfo> _article;
  List<ArticleInfo> _filterarticle;

  String ida;
  final _debouncer = Debouncer(milliseconds: 500);
  ScrollController _arrowsController = ScrollController();
  @override
  void initState() {
    super.initState();
    _article = [];
    _filterarticle = [];
    _getArticle();
    Intl.defaultLocale = "th";
    initializeDateFormatting();
  }

  _getArticle() {
    ServicesArticle.getArticle().then((article) {
      setState(() {
        _article = article;
        _filterarticle = article;
      });

      print("Length: ${article.length}");
    });
  }

  searchField() {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.all(1.0),
          labelStyle: TextStyle(color: Colors.grey, fontFamily: 'Prompt'),
          labelText: 'ค้นหาบทความ :',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red[200])),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red[200])),
        ),
        onChanged: (string) {
          // We will start filtering when the user types in the textfield.
          // Run the debouncer and start searching
          _debouncer.run(() {
            // Filter the original List and update the Filter list
            setState(() {
              _filterarticle = _article
                  .where((u) => (u.topic
                          .toLowerCase()
                          .contains(string.toLowerCase()) ||
                      u.detail.toLowerCase().contains(string.toLowerCase())))
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
          rows: _filterarticle
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
                        ida = article.articlesid;
                        print(ida);
                        routeTS(ShowArticle(), article);
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
        'http://student.crru.ac.th/601463046/apidoctor/getArticleWhereId.php?isAdd=true&articles_id=$articlesid';
    await Dio().get(url).then((value) => {print('value = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('res = $result');
      for (var map in result) {
        ArticleInfo articleInfo = ArticleInfo.fromJson(map);
        if (articlesid == articleInfo.articlesid) {
          routeTS(ShowArticle(), articleInfo);
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTS(Widget myWidgett, ArticleInfo articleInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('articles_id', articleInfo.articlesid);
    preferences.setString('topic', articleInfo.topic);
    preferences.setString('detail', articleInfo.detail);
    preferences.setString('issue_date', articleInfo.issuedate);
    preferences.setString('id', articleInfo.id);
    preferences.setString('doctorname', articleInfo.doctorname);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
  }

  Future<Null> refreshList() async {
    ServicesArticle.getArticle().then((article) {
      setState(() {
        _article = article;
        _filterarticle = article;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'บทความ',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: searchField(),
            ),
            // Expanded(
            //   child: _dataBody(),
            // ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: refreshList,
                backgroundColor: Colors.pink[200],
                child: DraggableScrollbar.arrows(
                  alwaysVisibleScrollThumb: true,
                  controller: _arrowsController,
                  padding: EdgeInsets.only(right: 4.0),
                  backgroundColor: Colors.pink[200],
                  child: ListView.builder(
                    controller: _arrowsController,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: _filterarticle.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                              routeTS(ShowArticle(), _filterarticle[index]);
                            },
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(_filterarticle[index].topic,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            style: TextStyle(
                                              fontSize: 14.0,
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
            ),
          ],
        ),
      ),
    );
  }
}
