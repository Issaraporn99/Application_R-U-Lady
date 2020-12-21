import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/question_modal.dart';
import 'package:doctorpurin/screen/disease/service.dart';
import 'package:doctorpurin/screen/qa/qa.dart';
import 'package:doctorpurin/screen/qa/showA.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowQA extends StatefulWidget {
  ShowQA() : super();
  @override
  _ShowQAState createState() => _ShowQAState();
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

class _ShowQAState extends State<ShowQA> {
  List<Question> _filterqa;
  List<Question> _qa;

  String ida;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _filterqa = [];
    _qa = [];
    _getQa();
    Intl.defaultLocale = "th";
    initializeDateFormatting();
  }

  _getQa() {
    ServicesQA.getQ().then((qa) {
      setState(() {
        _qa = qa;
        _filterqa = qa;
      });

      print("Length: ${qa.length}");
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
          labelText: 'ค้นหาคำถาม :',
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
              _filterqa = _qa
                  .where((u) => (u.question
                          .toLowerCase()
                          .contains(string.toLowerCase()) ||
                      u.questionDate
                          .toLowerCase()
                          .contains(string.toLowerCase())))
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
                "คำถาม",
                style: TextStyle(fontFamily: 'Prompt'),
              ),
            ),
            DataColumn(
              label: Text(
                "วันที่",
                style: TextStyle(
                  fontFamily: 'Prompt',
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
          rows: _filterqa
              .map(
                (qa) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        qa.question,
                        style: TextStyle(fontFamily: 'Prompt'),
                      ),
                      onTap: () {
                        routeTS(ShowA(), qa);
                      },
                    ),
                    DataCell(
                      Text(
                        qa.questionDate,
                        style: TextStyle(
                            fontFamily: 'Prompt',
                            fontSize: 10.0,
                            color: Colors.black45),
                      ),
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
    String questionId = preferences.getString('question_id');

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getQAWhereId.php?isAdd=true&question_id=$questionId';
    await Dio().get(url).then((value) => {print('value = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('res = $result');
      for (var map in result) {
        Question qaInfo = Question.fromJson(map);
        if (questionId == qaInfo.questionId) {
          routeTS(ShowA(), qaInfo);
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTS(Widget myWidgett, Question qaInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('question_id', qaInfo.questionId);
    preferences.setString('question', qaInfo.question);
    preferences.setString('question_date', qaInfo.questionDate);
    preferences.setString('question_name', qaInfo.questionName);
    preferences.setString('expertise_id', qaInfo.expertiseId);
    preferences.setString('answer_id', qaInfo.answerId);
    preferences.setString('answer_name', qaInfo.answerName);
    preferences.setString('answer_date', qaInfo.answerDate);
    preferences.setString('id', qaInfo.id);
    preferences.setString('doctorname', qaInfo.doctorname);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'คำถาม',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.red[200],
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
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70, right: 10),
                child: FloatingActionButton(
                  backgroundColor: const Color(0xff03dac6),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QandA()));
                  },
                  child: Icon(Icons.edit),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
