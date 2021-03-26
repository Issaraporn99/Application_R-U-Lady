import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:doctorpurin/utility/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:doctorpurin/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QandA extends StatefulWidget {
  @override
  _QandAState createState() => _QandAState();
}

class _QandAState extends State<QandA> {
  String selectedValue;
  List exItem = List();
  String question;
  String questionDate;
  String questionName;
  String expertiseId;
  String questionId;

  Future getex() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // setState(() {
    //   selectedValue = preferences.getString('expertise_id');
    //   print("$selectedValue");
    // });

    var url =
        "http://student.crru.ac.th/601463046/apidoctor/getExType.php?isAdd=true";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        exItem = jsonData;
      });
    }
    print(exItem);
  }

  @override
  void initState() {
    super.initState();
    getex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สอบถามผู้เชี่ยวชาญ',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Prompt',
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      backgroundColor: Colors.white,
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: RadialGradient(
        //     colors: <Color>[Colors.white, MyStyle().primaryColor],
        //     center: Alignment(0, -0.3),
        //     radius: 1.0,
        //   ),
        // ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  './images/3748550.jpg',
                  width: 500,
                  // height: 200,
                ),
                MyStyle().mySizeBox(),
                MyStyle().showTitleH2('เลือกสาขาความเชี่ยวชาญ :'),
                MyStyle().mySizeBox(),
                DropdownButton(
                  hint: Text('เลือก',
                      style: TextStyle(fontFamily: 'Prompt', fontSize: 18)),
                  value: selectedValue,
                  items: exItem.map((ex) {
                    return DropdownMenuItem(
                        value: ex['expertise_id'],
                        child: Text(
                          ex['expertise_name'],
                          style: TextStyle(fontFamily: 'Prompt', fontSize: 18),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      expertiseId = selectedValue;
                    });
                    print(expertiseId);
                  },
                ),
                MyStyle().mySizeBox(),
                MyStyle().mySizeBox(),
                userForm(),
                MyStyle().mySizeBox(),
                qustion(),
                MyStyle().mySizeBox(),
                MyStyle().mySizeBox(),
                registerButton(),
                MyStyle().mySizeBox(),
                MyStyle().mySizeBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registerButton() => Container(
      width: 250.0,
      height: 50,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: RaisedButton(
            color: Colors.teal[400],
            onPressed: () {
              if ('$question' == "null") {
                normalDialog3(context, 'ยังไม่ได้ป้อนคำถาม');
              } else if ('$expertiseId' == "null") {
                normalDialog3(context, 'กรุณาเลือกสาขาความเชี่ยวชาญ');
              } else {
                print(
                    'question_id = $questionId,question = $question, question_name = $questionName, expertise_id = $expertiseId,question_date=$questionDate');
                registerThread();
              }
            },
            child: Text('ถาม',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Prompt', fontSize: 18.0)),
          )));

  Future<Null> registerThread() async {
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/addQustion.php?isAdd=true&question=$question&question_name=$questionName&expertise_id=$expertiseId';

    try {
      Response response = await Dio().get(url);
      print('res=$response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog3(context, 'กรุณาเลือกสาขาความเชี่ยวชาญ');
      }
    } catch (e) {}
  }

  Widget qustion() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 250.0,
              child: TextField(
                onChanged: (value) => question = value.trim(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.border_color,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(
                      color: MyStyle().darkColor,
                      fontFamily: 'Prompt',
                      fontSize: 18),
                  labelText: 'ถามคำถาม :',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().primaryColor)),
                ),
              )),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 250.0,
              child: TextField(
                onChanged: (value) => questionName = value.trim(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.face,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(
                      color: MyStyle().darkColor,
                      fontFamily: 'Prompt',
                      fontSize: 18),
                  labelText: 'ชื่อ :',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().primaryColor)),
                ),
              )),
        ],
      );
}
