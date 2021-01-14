import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ShowResult extends StatefulWidget {
  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  String diseaseId;
  String symptomId;
  String expertiseId;
  String text = "";
  String text2 = "";

  var diseaseName = new List();
  var symptomName = new List();

  @override
  void initState() {
    super.initState();
    show();
  }

  Future<Null> show() async {
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getresult.php?isAdd=true';
    await Dio().get(url).then((value) => {print('show = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print("$result");
    setState(() {
      for (var x in result) {
        diseaseName.add(x['disease_name']);
      }
      for (var x in diseaseName) {
        text = x;
      }
      print("ล่าสุด=$text");
      for (var x in result) {
        symptomName.add(x['symptom_name']);
      }
      String text2 = "";
      int cnum2 = symptomName.length;
      int i2 = 1;
      for (var x in symptomName) {
        if (i2 == cnum2) {
          text2 = x;
        } else {
          text2 = text2 + x + ",";
        }
        i2++;
      }
      print("ล่าสุด=$text2");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ผลการตรวจโรค',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.red[200],
      ),
      body: Container(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "อาการที่ตอบใช่",
                    style: TextStyle(
                      color: Colors.redAccent[100],
                      fontFamily: 'Prompt',
                      fontSize: 18.0,
                    ),
                  ),
                  // Text(
                  //   "$symptomName",
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontFamily: 'Prompt',
                  //     fontSize: 18.0,
                  //   ),
                  // ),
                  Text(
                    "คุณมีแนวโน้มที่จะเป็นโรค",
                    style: TextStyle(
                      color: Colors.redAccent[100],
                      fontFamily: 'Prompt',
                      fontSize: 18.0,
                    ),
                  ),
                  Text('" $text "',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontFamily: 'Prompt',
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
