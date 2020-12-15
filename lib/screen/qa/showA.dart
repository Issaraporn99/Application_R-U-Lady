import 'package:doctorpurin/screen/women_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ShowA extends StatefulWidget {
  @override
  _ShowAState createState() => _ShowAState();
}

class _ShowAState extends State<ShowA> {
  String questionId;
  String question;
  String questionDate;
  String questionName;
  String expertiseId;
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
      questionId = preferences.getString('question_id');
      question = preferences.getString('question');
      questionDate = preferences.getString('question_date');
      questionName = preferences.getString('question_name');
      expertiseId = preferences.getString('expertise_id');
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
                    '$questionName',
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
                        data: ('$question'),
                      )),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      '$questionName',
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
                      'ผู้เขียน $expertiseId',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
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
              ],
            ),
          ),
        ));
  }
}