import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/question_modal.dart';
import 'package:doctorpurin/screen/disease/service.dart';
import 'package:doctorpurin/screen/qa/qa.dart';
import 'package:doctorpurin/screen/qa/showA.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShowQA2 extends StatefulWidget {
  ShowQA2() : super();
  @override
  _ShowQA2State createState() => _ShowQA2State();
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

class _ShowQA2State extends State<ShowQA2> {
  List<Question> _filterqa;
  List<Question> _qa;
  List<Question> articleD = List();
  String ida;
  final _debouncer = Debouncer(milliseconds: 500);

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _getQa();
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    setState(() {});
    _refreshController.loadComplete();
  }

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
    ServicesQA2.getQ().then((qa) {
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
                      u.expertiseName
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
                        print(qa.questionId);
                        routeTS(ShowA(), qa);
                      },
                    ),
                    DataCell(
                      Text(
                        qa.questionDate + ' น.',
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

        setState(() {
          articleD.add(qaInfo);
          routeTS(ShowA(), qaInfo);
        });
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
    preferences.setString('expertise_name', qaInfo.expertiseName);
    preferences.setString('answer_id', qaInfo.answerId);
    preferences.setString('answer_name', qaInfo.answerName);
    preferences.setString('answer_date', qaInfo.answerDate);
    preferences.setString('id', qaInfo.id);
    preferences.setString('doctorname', qaInfo.doctorname);
    preferences.setString('COUNT(answer_id)', qaInfo.cOUNTAnswerId);
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
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropMaterialHeader(
          backgroundColor: Colors.pinkAccent[100],
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff03dac6),
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => QandA()));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
