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
          title: Text('ถามตอบ',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.red[200],
      ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'คำถามที่ $questionId',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 150, top: 20),
                      child: Text(
                        'วันที่ $questionDate',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ]),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 20),
                      child: Text('$question')),
                ),
                if ('$questionName' != null)
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,top: 20
                      ),
                      child: Text(
                        'คำถามจาก คุณ $questionName',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
