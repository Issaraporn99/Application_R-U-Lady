import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/question_modal.dart';
import 'package:doctorpurin/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ShowAn extends StatefulWidget {
  @override
  _ShowAnState createState() => _ShowAnState();
}

class _ShowAnState extends State<ShowAn> {
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
  String cOUNTAnswerId;
  List<Question> groupInfo = List();
  @override
  void initState() {
    super.initState();
    findId();
    showGetArticle();
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
      cOUNTAnswerId = preferences.getString('COUNT(answer_id)');
    });
  }

  Future<Null> showGetArticle() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String questionId = preferences.getString('question_id');

    String url =
        'http://192.168.43.187/apidoctor/getQAWhereId.php?isAdd=true&question_id=$questionId';
    await Dio().get(url).then((value) => {print('value = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('res = $result');
      for (var map in result) {
        Question qaInfo = Question.fromJson(map);

        // print(questionId);
        setState(() {
          groupInfo.add(qaInfo);
        });
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ถามตอบ',
          style: TextStyle(
              color: Colors.white, fontFamily: 'Prompt', fontSize: 18.0),
        ),
        backgroundColor: Colors.red[200],
      ),
      body: groupInfo.length == 0
          ? MyStyle().showProgress()
          : ListView.builder(
              itemCount: groupInfo.length,
              itemBuilder: (context, index) => SingleChildScrollView(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                constraints:
                                    BoxConstraints(minWidth: double.infinity),
                                child: Text(
                                  doctorname == null
                                      ? ''
                                      : 'ตอบโดยผู้เชี่ยวชาญ ' +
                                          groupInfo[index].doctorname,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13.0,
                                      fontFamily: 'Prompt'),
                                ),
                              ),
                              Container(
                                constraints:
                                    BoxConstraints(minWidth: double.infinity),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    answerName == null
                                        ? '* ยังไม่มีคำตอบ'
                                        : groupInfo[index].answerName,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontFamily: 'Prompt'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            ),
    );
  }
}
