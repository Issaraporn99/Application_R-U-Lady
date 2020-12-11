import 'package:doctorpurin/screen/women_home.dart';
import 'package:flutter/material.dart';
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
          title: Text('บทความ'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 15, bottom: 5),
                  child: Text(
                    '$topic',
                    style: TextStyle(
                      color: Colors.purple[300],
                      fontSize: 18.0,
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 50),
                      child: Html(
                        data: ('$detail'),
                      )),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      '$issuedate',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      'ผู้เขียน $doctorname',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),

                // CarouselSlider(
                //   items: [showData(),],
                //   options: CarouselOptions(enlargeCenterPage: true, height: 400),
                //   carouselController: _controller,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     Padding(
                //       padding: const EdgeInsets.only(bottom: 20),
                //       child: FlatButton(
                //         onPressed: () => _controller.previousPage(),
                //         child: Image.asset(
                //           'images/pre.png',
                //           width: 30,
                //         ),
                //       ),
                //     ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => WomenHome()));
                    },
                    child: Image.asset(
                      'images/btnh.png',
                      width: 60,
                    ),
                  ),
                ),
                //     Padding(
                //       padding: const EdgeInsets.only(bottom: 20),
                //       child: FlatButton(
                //         onPressed: () => _controller.nextPage(),
                //         child: Image.asset(
                //           'images/next.png',
                //           width: 30,
                //         ),
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ));
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
