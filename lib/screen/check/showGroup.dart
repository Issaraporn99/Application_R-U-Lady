import 'dart:convert';
import 'package:doctorpurin/screen/check/newShowSym.dart';
import 'package:doctorpurin/screen/check/newShowSym2.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:doctorpurin/screen/check/showSym.dart';
import 'package:doctorpurin/screen/check/showsym2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowGroup extends StatefulWidget {
  @override
  _ShowGroupState createState() => _ShowGroupState();
}

class _ShowGroupState extends State<ShowGroup> {
  String groupId;
  String groupName;
  String organId;
  String organName="...";
  String symptomName;
  String symptomId;
  String diseaseId;
  String id;
  String idname;
  String status;
  var diss = new List();
  var diss2 = new List();
  var symm = new List();
  var gg = new List();

  var dess = new List();
  var groupp = new List();
  var d = new List<String>();
  var s = new List<String>();
  var de = new List<String>();
  var gr = new List<String>();

  List<int> myModels = [];
  List<GroupSym> groupInfo = List();
  List<GroupSym> symInfo = List();
  @override
  void initState() {
    super.initState();
    findId();
    del();
  }

  // ลบข้อมูลใน ตาราง get_dis
  Future<Null> del() async {
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/deleteGetdis.php?&isAdd=true';
    await Dio().get(url).then((value) => {print('del = $value')});
    Response response = await Dio().get(url);
  }
  // ลบข้อมูลใน ตาราง get_dis

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    organId = preferences.getString('organ_id');
    organName = preferences.getString('organ_name');
    symptomName = preferences.getString('symptom_name');
    symptomId = preferences.getString('symptom_id');
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    // await Dio().get(url).then((value) => {print('value = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    for (var map in result) {
      GroupSym model = GroupSym.fromJson(map);
      setState(() {
        groupInfo.add(model);
      });
    }
  }

  Future<Null> routeTsS(Widget myWidgett, GroupSym sym) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('group_id', sym.groupId);
    preferences.setString('symptom_name', sym.symptomName);
    preferences.setString('symptom_id', sym.symptomId);
    preferences.setString('disease_id', sym.diseaseId);
    preferences.setString('group_name', sym.groupName);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => myWidgett));
  }

  Future<Null> apisym4() async {
    diss2 = [];
    print("id=$id");
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym4.php?group_id=$id&isAdd=true';
    await Dio().get(url).then((value) => {print('valueSymId = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    setState(() {
      for (var x in result) {
        diss2.add(x['disease_id']);
      }
    });
    apisym41();
  }

  Future<Null> apisym41() async {
    await del();
    diss = [];
    symm = [];
    gg = [];

    String text = "";
    int cnum = diss2.length;
    int i = 1;
    for (var x in diss2) {
      if (i == cnum) {
        text = text + x;
      } else {
        text = text + x + ",";
      }
      i++;
    }
    print("text1=$text");
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym41.php?&text=$text&isAdd=true';
    await Dio().get(url).then((value) => {print('apisym41 = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print("reeee$result");
    for (var x in result) {
      diss.add(x['disease_id']);
    }

    for (var x in result) {
      symm.add(x['symptom_id']);
    }
    for (var x in result) {
      gg.add(x['group_id']);
    }

    await addToDB2();
  }

  Future<Null> addToDB2() async {
    var url = 'http://student.crru.ac.th/601463046/apidoctor/add.php';
    var map = new Map<String, dynamic>();
    String a = "";
    int n = 0;
    for (var x in diss) {
      a = x;
      map["diss[$n]"] = a;
      n++;
    }
    String b = "";
    int n2 = 0;
    for (var x in symm) {
      b = x;
      map["symm[$n2]"] = b;
      n2++;
    }
    String c = "";
    int n3 = 0;
    for (var x in gg) {
      c = x;
      map["gg[$n3]"] = c;
      n3++;
    }
    final response = await http.post(url, body: map);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print("id=$id");
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowSym()));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('group_id', id);
    preferences.setString('group_name', idname);
    preferences.setString('symptom_name', symptomName);
  }

  Future<Null> noname() async {
    await del();
    d = [];
    s = [];
    gr = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    organId = preferences.getString('organ_id');
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroupNoName.php?organ_id=$organId&isAdd=true';
    await Dio().get(url).then((value) => {print('noname = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);

    for (var x in result) {
      d.add(x['disease_id']);
    }

    for (var x in result) {
      s.add(x['symptom_id']);
    }
    for (var x in result) {
      gr.add(x['group_id']);
    }
    insertToDB2();
  }

  Future<Null> insertToDB2() async {
    var url = 'http://student.crru.ac.th/601463046/apidoctor/add.php';
    var map = new Map<String, dynamic>();
    String a = "";
    int n = 0;
    for (var x in d) {
      a = x;
      map["diss[$n]"] = a;
      n++;
    }
    String b = "";
    int n2 = 0;
    for (var x in s) {
      b = x;
      map["symm[$n2]"] = b;
      n2++;
    }
    String c = "";
    int n3 = 0;
    for (var x in gr) {
      c = x;
      map["gg[$n3]"] = c;
      n3++;
    }
    final response = await http.post(url, body: map);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShowSym2()));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('group_id', id);
    preferences.setString('group_name', idname);
    preferences.setString('symptom_name', symptomName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'คุณมีความผิดปกติเกี่ยวกับ ?',
          style: TextStyle(
              color: Colors.white, fontFamily: 'Prompt', fontSize: 18.0),
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "คุณมีความผิดปกติเกี่ยวกับส่วนใดของ $organName" ?? "...",
              style: TextStyle(color: Colors.black, fontFamily: 'Prompt'),
            ),
          ),
          nono(),
          new Expanded(
            child: new ListView.builder(
              itemCount: groupInfo.length,
              itemBuilder: (context, index) {
                return an_builder(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget an_builder(context, index) {
    return SingleChildScrollView(
      child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: SizedBox(
              height: 63,
              child: InkWell(
                splashColor: Colors.white,
                onTap: () {
                  id = groupInfo[index].groupId;
                  idname = groupInfo[index].groupName;
                  apisym4();
                  // routeTsS(NewShowSym(), groupInfo[index]);
                },
                child: Card(
                  elevation: 1.5,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 17, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              groupInfo[index].groupName,
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'Prompt'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget nono() => Container(
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: SizedBox(
              height: 63,
              child: InkWell(
                splashColor: Colors.white,
                onTap: () {
                  noname();
                },
                child: Card(
                  elevation: 1.5,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 17, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ไม่ระบุ",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'Prompt'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
