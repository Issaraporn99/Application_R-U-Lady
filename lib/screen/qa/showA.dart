import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String answerId;
  String answerName;
  String answerDate;
  String id;
  String doctorname;

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
      answerId = preferences.getString('answer_id');
      answerName = preferences.getString('answer_name');
      answerDate = preferences.getString('answer_date');
      id = preferences.getString('id');
      doctorname = preferences.getString('doctorname');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ถามตอบ',
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
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'คำถามจาก คุณ $questionName',
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
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'ตอบ $answerName',
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
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'คำตอบจาก ผู้เชี่ยวชาญ $doctorname',
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
