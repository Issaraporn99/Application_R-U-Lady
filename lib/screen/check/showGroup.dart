import 'dart:convert';
import 'package:doctorpurin/main.dart';
import 'package:doctorpurin/screen/check/newShowSym.dart';
import 'package:doctorpurin/screen/check/newShowSym2.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:doctorpurin/screen/check/showSym.dart';
import 'package:doctorpurin/screen/check/showsym2.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowGroup extends StatefulWidget {
  @override
  _ShowGroupState createState() => _ShowGroupState();
}

class _ShowGroupState extends State<ShowGroup> {
  String groupId;
  String groupName;
  String organId;
  String organName = "...";
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
  var bf = new List();
  var dess = new List();
  var groupp = new List();
  var d = new List<String>();
  var d2 = new List<String>();
  var s = new List<String>();
  var de = new List<String>();
  var gr = new List<String>();
  var bb = new List<String>();

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

  Future<Null> upSD() async {
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/updateSD.php?isAdd=true';
    await Dio().get(url);
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
    await upSD();
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
    for (var x in result) {
      diss.add(x['disease_id']);
    }

    for (var x in result) {
      symm.add(x['symptom_id']);
    }
    for (var x in result) {
      gg.add(x['group_id']);
    }
    for (var x in result) {
      bf.add(x['before_id']);
    }

    await addToDB2();
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowSym()));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('group_id', id);
    preferences.setString('group_name', idname);
    preferences.setString('symptom_name', symptomName);
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
    String d = "";
    int n4 = 0;
    for (var x in bf) {
      d = x;
      map["bf[$n4]"] = d;
      n4++;
    }
    final response = await http.post(url, body: map);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print("id=$id");
  }

  Future<Null> noname() async {
    await del();
    await upSD();
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

    setState(() {
      for (var x in result) {
        diss2.add(x['disease_id']);
      }
    });
    noname2();
  }

  Future<Null> noname2() async {
    await del();
    d = [];
    s = [];
    gr = [];
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
    SharedPreferences preferences = await SharedPreferences.getInstance();
    organId = preferences.getString('organ_id');
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym41.php?&text=$text&isAdd=true';
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
    for (var x in result) {
      bb.add(x['before_id']);
    }
    await insertToDB2();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ShowSym2()));
    preferences.setString('group_id', id);
    preferences.setString('group_name', idname);
    preferences.setString('symptom_name', symptomName);
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
    String f = "";
    int n4 = 0;
    for (var x in bb) {
      f = x;
      map["bf[$n4]"] = f;
      n4++;
    }
    final response = await http.post(url, body: map);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFBFA),
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
              "$organName" ?? "...",
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Prompt', fontSize: 18),
            ),
          ),
          groupInfo.length == 1
              ? Container()
              : Container(
                  margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple[100].withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ]),
                  child: ButtonTheme(
                    minWidth: 500.0,
                    height: 50.0,
                    child: FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        noname();
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text("ไม่ระบุ/ไม่ทราบ",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'Prompt',
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            LineIcons.angle_right,
                            color: Colors.black38,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          new Expanded(
            child: new ListView.builder(
              itemCount: groupInfo.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple[100].withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ]),
                  child: ButtonTheme(
                    minWidth: 500.0,
                    height: 50.0,
                    child: FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        id = groupInfo[index].groupId;
                        idname = groupInfo[index].groupName;
                        apisym4();
                      },
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(groupInfo[index].groupName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'Prompt',
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            LineIcons.angle_right,
                            color: Colors.black38,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 15,
                          right: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              groupInfo[index].groupName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Prompt',
                                  fontSize: 18),
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
                                  color: Colors.black,
                                  fontFamily: 'Prompt',
                                  fontSize: 18),
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
