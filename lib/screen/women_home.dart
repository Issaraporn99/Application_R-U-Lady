import 'package:doctorpurin/screen/article/article.dart';
import 'package:doctorpurin/screen/check/check_disease.dart';
import 'package:doctorpurin/screen/disease_menu.dart';
import 'package:doctorpurin/screen/qa/qa.dart';
import 'package:flutter/material.dart';
import 'package:doctorpurin/utility/my_style.dart';

import 'check/check_disease.dart';


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
        title: Text('   รู้ทันปัญหาสุขภาพผู้หญิง'),
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
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/home.png'),
              alignment: Alignment.bottomCenter,
              scale: 2.5

              //  width: 65,
              //  height: 65,

              ),
        ),
      ),
    );
  }

  Widget checkButton() => Container(
        child: SizedBox(
          width: 150,
          height: 139,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CheckDisease()));
            },
            color: Color(0xFFDF7599),
            padding: EdgeInsets.all(20),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  './images/cd.png',
                  width: 65,
                  height: 65,
                ),
                Expanded(
                  child: Text('ตรวจโรค',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
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
          width: 150,
          height: 139,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DiseaseMenu()));
            },
            color: Color(0xFF1A2849),
            padding: EdgeInsets.all(20),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  './images/info.png',
                  width: 65,
                  height: 65,
                ),
                Expanded(
                  child: Text(
                    'ข้อมูลโรค',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
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
          height: 139,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Article()));
            },
            color: Color(0xFF009F9D),
            padding: EdgeInsets.all(20),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  './images/artc.png',
                  width: 65,
                  height: 65,
                ),
                Expanded(
                  child: Text(
                    'บทความ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
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
          height: 139,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => QandA()));
            },
            color: Color(0xFF07456F),
            padding: EdgeInsets.all(20),
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  './images/qa.png',
                  width: 65,
                  height: 65,
                ),
                Expanded(
                  child: Text(
                    'ถามตอบ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
