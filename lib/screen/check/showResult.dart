import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/main.dart';
import 'package:doctorpurin/modal/result_modal.dart';
import 'package:doctorpurin/screen/disease/showdis.dart';
import 'package:doctorpurin/screen/qa/qa.dart';
import 'package:doctorpurin/screen/women_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowResult extends StatefulWidget {
  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  String symptomId;
  String expertiseId;
  String text = "";
  String id = "";

  String desId;

  String groupId;
  String yn;
  String groupName;
  String organId;
  String symptomName;
  String desName;
  String diseaseDetail;
  String diseaseCause;
  String diseaseRisk;
  String diseaseChance;
  String diseaseTreatment;
  String diseaseDefence;
  String diseaseAbout;
  String expertiseName;
  List<Getdissym> groupSym = List();
  var diseaseName = new List();
  var diseaseId = new List();

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
      for (var x in result) {
        diseaseId.add(x['disease_id']);
      }
      for (var x in diseaseId) {
        id = x;
      }
      for (var map in result) {
        Getdissym disInfo = Getdissym.fromJson(map);
        setState(() {
          groupSym.add(disInfo);
        });
      }
    });
  }

  Future<Null> show2() async {
     id = "";
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getrs2.php?isAdd=true';
    await Dio().get(url).then((value) => {print('show2 = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    setState(() {
      for (var map in result) {
        Getdissym disInfo = Getdissym.fromJson(map);
        if (id == disInfo.diseaseId) {
          routeTS(ShowDis(), disInfo);
        }
      }
    });

    saveToDig();
  }

  Future<Null> routeTS(Widget myWidgett, Getdissym disInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('disease_id', disInfo.diseaseId);
    preferences.setString('disease_name', disInfo.diseaseName);
    preferences.setString('disease_detail', disInfo.diseaseDetail);
    preferences.setString('disease_cause', disInfo.diseaseCause);
    preferences.setString('disease_risk', disInfo.diseaseRisk);
    preferences.setString('disease_chance', disInfo.diseaseChance);
    preferences.setString('disease_treatment', disInfo.diseaseTreatment);
    preferences.setString('disease_defence', disInfo.diseaseDefence);
    preferences.setString('disease_about', disInfo.diseaseAbout);
    preferences.setString('expertise_id', disInfo.expertiseId);
    preferences.setString('expertise_name', disInfo.expertiseName);

    Navigator.push(context, MaterialPageRoute(builder: (context) => myWidgett));
    // MaterialPageRoute route =
    //     MaterialPageRoute(builder: (context) => myWidgett);
    // Navigator.push(context, route);
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => myWidgett));
  }

  Future<Null> saveToDig() async {
    print("id=$id");
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/saveToDig.php?isAdd=true&id=$id';
    await Dio().get(url).then((value) => {print('saveToDig = $url')});
    // Response response = await Dio().get(url);
    // del();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'ผลการตรวจโรค',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "คุณมีแนวโน้มที่จะเป็นโรค",
                      style: TextStyle(
                        color: Color(0xFF1687a7),
                        fontFamily: 'Prompt',
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text('" $text "',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontFamily: 'Prompt',
                      )),
                ),
                button(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 10, right: 10, bottom: 10),
                  child: Text(
                    "หมายเหตุ : หากคุณมีอาการผิดปกติ ควรปรึกษาแพทย์ผู้เชี่ยวชาญ",
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Prompt',
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 10),
                    child: Text(
                      "อาการที่มี",
                      style: TextStyle(
                        color: Color(0xFF1687a7),
                        fontFamily: 'Prompt',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    height: 200,
                    child: new ListView.builder(
                      itemCount: groupSym.length,
                      itemBuilder: (context, index) {
                        return an_builder(context, index);
                      },
                    ),
                  ),
                ),
                button2(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent[100],
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
        child: Icon(Icons.home),
      ),
    );
  }

  Widget button2() => Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 200,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: RaisedButton(
                onPressed: () {
                  saveToDig();
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) => QandA());
                  Navigator.push(context, route);
                },
                color: Color(0xFF6ddccf),
                elevation: 8,
                child: Text(
                  'สอบถามผู้เชี่ยวชาญ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  Widget button() => Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 200,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: RaisedButton(
                onPressed: () {
                  show2();
                },
                color: Color(0xFF1687a7),
                elevation: 3,
                child: Text(
                  'อ่านข้อมูลเพิ่มเติม',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  Widget an_builder(context, index) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10, top: 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "- " + groupSym[index].symptomName,
                style: TextStyle(color: Colors.black, fontFamily: 'Prompt'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
