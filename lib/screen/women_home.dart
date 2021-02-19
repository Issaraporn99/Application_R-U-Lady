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
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage('images/home.png'),
        //       alignment: Alignment.bottomCenter,
        //       scale: 2.5

        //       //  width: 65,
        //       //  height: 65,

        //       ),
        // ),
      ),
    );
  }

  Widget checkButton() => Container(
        child: SizedBox(
          width: 140,
          height: 139,
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
                  child: Text('ตรวจโรค',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[600],
                        fontFamily: 'Prompt',
                      )),
                ),
              ],
            ),
          ),
        ),
      );

  Widget diseaseButton() => Container(
        child: SizedBox(
          width: 140,
          height: 139,
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
                  child: Text(
                    'ข้อมูลโรค',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18.0,
                      fontFamily: 'Prompt',
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
          width: 140,
          height: 139,
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
                  child: Text(
                    'บทความ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18.0,
                      fontFamily: 'Prompt',
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
          width: 140,
          height: 139,
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
                  child: Text(
                    'ถามตอบ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18.0,
                      fontFamily: 'Prompt',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
