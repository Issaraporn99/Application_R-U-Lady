import 'package:doctorpurin/screen/check/check_disease.dart';
import 'package:doctorpurin/screen/disease/disease_info.dart';
import 'package:doctorpurin/screen/qa/showQA.dart';
import 'package:flutter/material.dart';
import 'package:doctorpurin/utility/my_style.dart';

import 'check/check_disease.dart';
import 'includes/article.dart';

class WomenHome extends StatefulWidget {
  @override
  _WomenHomeState createState() => _WomenHomeState();
}

class _WomenHomeState extends State<WomenHome> {
//Field
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFBFA),
      appBar: AppBar(
        title: Text(
          ' รู้ทันปัญหาสุขภาพผู้หญิง',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  checkButton(),
                  MyStyle().mySizeBox(),
                  articleButton(),
                ],
              ),
              Column(
                children: [
                  diseaseButton(),
                  MyStyle().mySizeBox(),
                  qaButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget checkButton() => Container(
        child: SizedBox(
          width: 150,
          height: 150,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckDisease()));
            },
            color: Color(0xFFf9c0c0),
            padding: EdgeInsets.all(20),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  './images/stethoscope.png',
                  width: 65,
                  height: 65,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'ตรวจโรค',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: 'Prompt',
                        shadows: [
                          Shadow(
                            color: Colors.red[900],
                            blurRadius: 2.0,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget diseaseButton() => Container(
        child: SizedBox(
          width: 150,
          height: 150,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DisInformation()));
            },
            color: Color(0xFFf6d6ad),
            padding: EdgeInsets.all(20),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  './images/medical-book.png',
                  width: 65,
                  height: 65,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'ข้อมูลโรค',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Prompt',
                        shadows: [
                          Shadow(
                            color: Colors.yellow[900],
                            blurRadius: 2.0,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget articleButton() => Container(
        child: SizedBox(
          width: 150,
          height: 150,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Article()));
            },
            color: Color(0xFFd3dbff),
            padding: EdgeInsets.all(20),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  './images/medical-record.png',
                  width: 65,
                  height: 65,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'บทความ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Prompt',
                        shadows: [
                          Shadow(
                            color: Colors.purple[800],
                            blurRadius: 2.0,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget qaButton() => Container(
        child: SizedBox(
          width: 150,
          height: 150,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ShowQA()));
            },
            color: Color(0xFFccf0e1),
            padding: EdgeInsets.all(20),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  './images/b.png',
                  width: 65,
                  height: 65,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'ถามตอบ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Prompt',
                        shadows: [
                          Shadow(
                            color: Colors.green[900],
                            blurRadius: 2.0,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
