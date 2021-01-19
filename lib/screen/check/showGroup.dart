import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:doctorpurin/screen/check/showSym.dart';
import 'package:doctorpurin/screen/check/showsym2.dart';
import 'package:doctorpurin/utility/normal_dialog.dart';
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
  String symptomName;
  String symptomId;
  String diseaseId;
  String id;
  String status;
  var diss = new List();
  var symm = new List();
  var statuss = new List();
  var ynn = new List();
  var d = new List();
  var s = new List();
  var st = new List();
  var y = new List();
  List<int> myModels = [];
  List<GroupSym> groupInfo = List();
  List<GroupSym> symInfo = List();
  @override
  void initState() {
    super.initState();
    findId();
  }

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    organId = preferences.getString('organ_id');
    symptomName = preferences.getString('symptom_name');
    symptomId = preferences.getString('symptom_id');
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    // await Dio().get(url).then((value) => {print('value = $value')});

    Response response = await Dio().get(url);
    // print('res = $response');

    var result = json.decode(response.data);

    // print('res = $result');

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
    preferences.setString('yn', sym.yn);
    preferences.setString('status', sym.status);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
  }

  Future<Null> apisym4() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // groupId = preferences.getString('group_id');
    print(id);
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym4.php?group_id=$id&isAdd=true';
    await Dio().get(url).then((value) => {print('valueSymId = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);

    for (var x in result) {
      diss.add(x['disease_id']);
    }

    for (var x in result) {
      symm.add(x['symptom_id']);
    }

    for (var x in result) {
      statuss.add(x['status']);
    }

    insertToDB();
  }

  Future<Null> insertToDB() async {
    String text1 = "";
    int cnum = diss.length;
    int i = 1;
    int n = 0;
    for (var x in diss) {
      if (i == cnum) {
        text1 = text1 + "diss[" + '$n' + "]=" + x;
      } else {
        text1 = text1 + "diss[" + '$n' + "]=" + x + "&";
      }
      n++;
      i++;
    }

    String text2 = "";
    int cnum2 = symm.length;
    int i2 = 1;
    int n2 = 0;
    for (var x2 in symm) {
      if (i2 == cnum2) {
        text2 = text2 + "symm[" + '$n2' + "]=" + x2;
      } else {
        text2 = text2 + "symm[" + '$n2' + "]=" + x2 + "&";
      }
      n2++;
      i2++;
    }

    String text3 = "";
    int cnum3 = statuss.length;
    int i3 = 1;
    int n3 = 0;
    for (var x3 in statuss) {
      if (i3 == cnum3) {
        text3 = text3 + "statuss[" + '$n3' + "]=" + x3;
      } else {
        text3 = text3 + "statuss[" + '$n3' + "]=" + x3 + "&";
      }
      n3++;
      i3++;
    }
    String text4 = "";
    int cnum4 = statuss.length;
    int i4 = 1;
    int n4 = 0;
    for (var x4 in statuss) {
      if (i4 == cnum4) {
        text4 = text4 + "ynn[" + '$n4' + "]=a";
      } else {
        text4 = text4 + "ynn[" + '$n4' + "]=a&";
      }
      n4++;
      i4++;
    }
    print("$text1&$text2&$text3&$text4");

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/addToDB.php?isAdd=true&$text1&$text2&$text3&$text4';

    try {
      Response response = await Dio().get(url);
      print('res=$response');
    } catch (e) {}
  }

  Future<Null> noname() async {
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
      st.add(x['status']);
    }
    print("result =$result");

    insertToDB2();
  }

  Future<Null> insertToDB2() async {
    String text1 = "";
    int cnum = d.length;
    int i = 1;
    int n = 0;
    for (var x in d) {
      if (i == cnum) {
        text1 = text1 + "diss[" + '$n' + "]=" + x;
      } else {
        text1 = text1 + "diss[" + '$n' + "]=" + x + "&";
      }
      n++;
      i++;
    }

    String text2 = "";
    int cnum2 = s.length;
    int i2 = 1;
    int n2 = 0;
    for (var x2 in s) {
      if (i2 == cnum2) {
        text2 = text2 + "symm[" + '$n2' + "]=" + x2;
      } else {
        text2 = text2 + "symm[" + '$n2' + "]=" + x2 + "&";
      }
      n2++;
      i2++;
    }
    print("text2=$text2");

    String text3 = "";
    int cnum3 = st.length;
    int i3 = 1;
    int n3 = 0;
    for (var x3 in st) {
      if (i3 == cnum3) {
        text3 = text3 + "statuss[" + '$n3' + "]=" + x3;
      } else {
        text3 = text3 + "statuss[" + '$n3' + "]=" + x3 + "&";
      }
      n3++;
      i3++;
    }

    String text4 = "";
    int cnum4 = st.length;
    int i4 = 1;
    int n4 = 0;
    for (var x4 in st) {
      if (i4 == cnum4) {
        text4 = text4 + "ynn[" + '$n4' + "]=a";
      } else {
        text4 = text4 + "ynn[" + '$n4' + "]=a&";
      }
      n4++;
      i4++;
    }

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/addToDB.php?isAdd=true&$text1&$text2&$text3&$text4';

   try {
      Response response = await Dio().get(url);
      print('res=$response');
    } catch (e) {
      print(e);
    }
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
        backgroundColor: Colors.red[200],
      ),
      body: new Column(
        children: <Widget>[
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
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 70,
              child: InkWell(
                splashColor: Colors.white,
                onTap: () {
                  routeTsS(ShowSym(), groupInfo[index]);
                  id = groupInfo[index].groupId;
                  print(id);
                  apisym4();
                },
                child: Card(
                  elevation: 1.5,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 17),
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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: SizedBox(
              height: 70,
              child: InkWell(
                splashColor: Colors.white,
                onTap: () {
                  noname();
                  // MaterialPageRoute route =
                  //     MaterialPageRoute(builder: (context) => ShowSym2());
                  // Navigator.push(context, route);
                },
                child: Card(
                  elevation: 1.5,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ไม่ทราบ",
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
