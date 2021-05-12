import 'package:doctorpurin/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ShowArticle extends StatefulWidget {
  @override
  _ShowArticleState createState() => _ShowArticleState();
}

class _ShowArticleState extends State<ShowArticle> {
  String articlesid;
  String topic;
  String detail;
  String issuedate;
  String id;
  String username;
  String password;
  String doctorname;
  String office;
  String userlevel;
  String expertiseId;
  String diseaseid;
  @override
  void initState() {
    super.initState();
    findId();
    Intl.defaultLocale = "th";
    initializeDateFormatting();
  }

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      articlesid = preferences.getString('articles_id');
      topic = preferences.getString('topic');
      detail = preferences.getString('detail');
      issuedate = preferences.getString('issue_date');
      id = preferences.getString('id');
      doctorname = preferences.getString('doctorname');
    });
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
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
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
      body: Stack(children: [
        SingleChildScrollView(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 5),
                    child: Text(
                      '$topic',
                      style: TextStyle(
                          color: Colors.red[900],
                          fontSize: 18.0,
                          fontFamily: 'Sarabun',
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Html(data: ('$detail'), style: {
                        "html": Style(
                          fontSize: FontSize(18.0),
                          padding: EdgeInsets.all(2.0),
                          // backgroundColor: Colors.white70,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Sarabun',
                        ),
                      })),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      '$issuedate',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Sarabun'),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 40),
                    child: Text(
                      'ผู้เผยแพร่ $doctorname',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Sarabun'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent[100],
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
        child: Icon(Icons.home),
      ),
    );
  }

  Widget showData() => Container(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Html(
                    data: ('$detail'),
                  )),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text('$issuedate'),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 5),
                child: Text('$id'),
              ),
            ),
          ],
        ),
      );
}
