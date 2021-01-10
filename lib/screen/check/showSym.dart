import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSym extends StatefulWidget {
  @override
  _ShowSymState createState() => _ShowSymState();
}

class _ShowSymState extends State<ShowSym> {
  String symptomId;
  String symptomName;
  String groupId;
  String diseaseId;
  String id;
  String dis;
  var aaa = new List();
  List<GroupSym> strArr = List();

  @override
  void initState() {
    super.initState();
    findId();
  }

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    symptomName = preferences.getString('symptom_name');
    symptomId = preferences.getString('symptom_id');
    String groupId = preferences.getString('group_id');

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym.php?group_id=$groupId&isAdd=true';
    await Dio().get(url).then((value) => {print('valueSSS = $value')});
    setState(() {
      symptomName = preferences.getString('symptom_name');
    });
  }

  Future<Null> idArray() async {
    id = '$symptomId';
    var arr = new List();

    arr.add(id);

    print('idddd=$arr');
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym2.php?symptom_id=$symptomId&isAdd=true';
    await Dio().get(url).then((value) => {print('valueSymId = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);

    for (var x in result) {
      aaa.add(x['disease_id']);
    }

    disArray();
  }

  Future<Null> disArray() async {
    String text = "";
    int cnum = aaa.length;
    print(cnum);
    int i = 1;
    for (var x in aaa) {
      if (i == cnum) {
        text = text + x;
      } else {
        text = text + x + ",";
      }
      i++;
    }
    print(text);
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym3.php?symptom_id=$symptomId&text=$text&isAdd=true';
    await Dio().get(url).then((value) => {print('valueSymId = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('aaaaa $result');
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'คุณมีอาการอะไรบ้าง?',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.red[200],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              sym(),
            ],
          ),
        ),
      ),
    );
  }

  Widget sym() => Container(
          child: SizedBox(
        width: 310,
        height: 320,
        child: Card(
          color: Colors.amber[50],
          elevation: 10,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(symptomName ?? "...",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontFamily: 'Prompt',
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: RaisedButton(
                        onPressed: () {
                          idArray();
                        },
                        color: Color(0xFF70af85),
                        padding: EdgeInsets.all(5),
                        child: Text('ใช่',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontFamily: 'Prompt',
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: RaisedButton(
                        onPressed: () {},
                        color: Color(0xFFdf7861),
                        padding: EdgeInsets.all(5),
                        child: Text('ไม่ใช่',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontFamily: 'Prompt',
                            )),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ));
}
