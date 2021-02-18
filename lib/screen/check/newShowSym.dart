import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:doctorpurin/screen/check/showResult.dart';
import 'package:doctorpurin/screen/check/showResult2.dart';
import 'package:doctorpurin/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewShowSym extends StatefulWidget {
  @override
  _NewShowSymState createState() => _NewShowSymState();
}

class _NewShowSymState extends State<NewShowSym> {
  String symptomId;
  String symptomName;
  String groupId = "";
  String idname = "";
  String diseaseId;
  String id;
  String des;
  String desName;
  String groupName;
  String desId;
  int d = 0;
  var symName = new List();
  var groupp = new List();
  var symm = new List();
  var diss = new List();
  var dess = new List();
  var ynn = new List();
  var gName = new List();
  var gd = new List();
  String del2dis = "";
  var del2diss = new List();
  String ardes = "";
  List<GroupSym> groupDes = List();
  @override
  void initState() {
    super.initState();
    findId();
  }

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
      idname = preferences.getString('group_name');
      id = preferences.getString('group_id');
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym.php?group_id=$id&isAdd=true';
    await Dio().get(url).then((value) => {print('findId = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print("result=$result");
    setState(() {
      for (var x in result) {
        symm.add(x['symptom_id']);
      }
      for (var x in symm) {
        symptomId = x;
      }
      for (var x in result) {
        symName.add(x['symptom_name']);
      }
      for (var x in symName) {
        symptomName = x;
      }


      groupId = id;
      groupName = idname;
    });
    print("id=$groupName");

    showdes();
  }

  Future<Null> showdes() async {
    print("symptomId=$symptomId");
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/newsym.php?&isAdd=true&symptom_id=$symptomId';
    await Dio().get(url).then((value) => {print('showdes = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print("result=$result");
    for (var map in result) {
      GroupSym model = GroupSym.fromJson(map);
      setState(() {
        groupDes.add(model);
        for (var x in result) {
          diss.add(x['disease_id']);
        }
      });
    }
  }

  Future<Null> count() async {
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/countSym.php?isAdd=true';
    Response response = await Dio().get(url);
    print('res=$response');
    if (response.toString() == 'null') {
      setState(() {
        d = 0;
        print("d null=$d");
        if (d == 0) {
          getDis2();
        }
      });
    } else {
      var result = json.decode(response.data);
      var dd = new List();
      setState(() {
        for (var x in result) {
          dd.add(x);
        }
        print(dd);

        d = dd.length;
        print("d=$d");
      });
    }
  }

  Future<Null> showNext() async {
    groupDes = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print("symptomId=$symptomId");
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/newsymnext.php?&isAdd=true&symptom_id=$symptomId';
    await Dio().get(url).then((value) => {print('showdes = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print("result=$result");
    for (var map in result) {
      GroupSym model = GroupSym.fromJson(map);
      setState(() {
        groupDes.add(model);
      });
    }
  }

  Future<Null> showdes2() async {
    diss = [];
    dess = [];
    print("desId=$desId");
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/newsym2.php?&isAdd=true&des_id=$desId';
    await Dio().get(url).then((value) => {print('showdes2 = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print("result=$result");
    setState(() {
      for (var x in result) {
        diss.add(x['disease_id']);
      }
      for (var x in result) {
        dess.add(x['des_id']);
      }
    });
    print("dis=$diss");
    print("des=$dess");
    await count();
    if (d <= 1) {
      getDis();
    } else {
      updateYN();
    }
  }

  Future<Null> updateYN() async {
    String tt1 = "";
    int cnum = diss.length;
    int i = 1;
    int n = 0;
    for (var x in diss) {
      if (i == cnum) {
        tt1 = tt1 + "diss[" + '$n' + "]=" + x;
      } else {
        tt1 = tt1 + "diss[" + '$n' + "]=" + x + "&";
      }
      n++;
      i++;
    }

    String tt2 = "";
    int cnum2 = dess.length;
    int i2 = 1;
    int n2 = 0;
    for (var x2 in dess) {
      if (i2 == cnum2) {
        tt2 = tt2 + "dess[" + '$n2' + "]=" + x2;
      } else {
        tt2 = tt2 + "dess[" + '$n2' + "]=" + x2 + "&";
      }
      n2++;
      i2++;
    }
    print("tt1$tt1");
    print("tt2$tt2");
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/updateYN.php?&$tt1&$tt2&isAdd=true';
    await Dio().get(url).then((value) => {print('updateYN = $value')});

    delsym();
  }

  Future<Null> delsym() async {
    String del = "";
    int cnum = diss.length;
    int i = 1;
    for (var x in diss) {
      if (i == cnum) {
        del = del + x;
      } else {
        del = del + x + ",";
      }
      i++;
    }
    print("del=$del");

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/delsym.php?&del=$del&isAdd=true';
    await Dio().get(url).then((value) => {print('del = $value')});
    Response response = await Dio().get(url);
    // var result = json.decode(response.data);
    findId2();
  }

  Future<Null> delsym2() async {
    String del = "";
    int cnum = diss.length;
    int i = 1;
    for (var x in diss) {
      if (i == cnum) {
        del = del + x;
      } else {
        del = del + x + ",";
      }
      i++;
    }
    print("del=$del");

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/delsym2.php?&del=$del&isAdd=true';
    await Dio().get(url).then((value) => {print('del2 = $value')});
    Response response = await Dio().get(url);
    // var result = json.decode(response.data);
    await count();
    findId2();
  }

  Future<Null> findId2() async {
    setState(() {
      symptomName = '';
      groupName = '';
      groupId = '';
      desName = '';
      diss = [];
      symName = [];
      symm = [];
      gName = [];
      groupp = [];
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/newsym3.php?&isAdd=true';
    await Dio().get(url).then((value) => {print('findId2 = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    if (response.toString() == 'null') {
      print("null");
    } else {
      setState(() {
        for (var x in result) {
          symName.add(x['symptom_name']);
        }
        String sn = "";
        for (var s in symName) {
          sn = sn + s;
        }
        for (var x in result) {
          diss.add(x['disease_id']);
        }
        for (var x in result) {
          groupp.add(x['group_id']);
        }
        for (var x in result) {
          gName.add(x['group_name']);
        }
        String snnn = "";
        for (var s in gName) {
          snnn = snnn + s;
        }
        for (var x in result) {
          symm.add(x['symptom_id']);
        }
        String snn = "";
        for (var s in symm) {
          snn = snn + s;
        }

        print(snnn);
        print(sn);
        symptomName = sn;
        symptomId = snn;
        groupName = snnn;
      });
      showNext();
    }
  }

  Future<Null> getDis() async {
    Navigator.pop(context);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => ShowResult());
    Navigator.push(context, route);
  }

  Future<Null> getDis2() async {
    Navigator.pop(context);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => ShowResult2());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffd3b6),
      appBar: AppBar(
        title: Text(
          'คุณมีอาการอะไรบ้าง?',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.red[200],
      ),
      body: new Column(
        children: <Widget>[
          sym(),
          nono(),
          new Expanded(
            child: new ListView.builder(
              itemCount: groupDes.length,
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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
            child: SizedBox(
              height: 70,
              child: InkWell(
                splashColor: Colors.white,
                onTap: () {
                  id = groupDes[index].desId;
                  print(id);
                  desId = id;
                  showdes2();
                },
                child: Card(
                  elevation: 1.5,
                  color: Color(0xFFffffff),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, top: 17, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              groupDes[index].desName,
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

  Widget sym() => Container(
      child: Padding(
          padding:
              const EdgeInsets.only(left: 10, top: 17, right: 10, bottom: 10),
          child: SizedBox(
            width: 330,
            child: Card(
              color: Color(0xFFffffdd),
              elevation: 10,
              child: Container(
                constraints:
                    BoxConstraints(minHeight: 100, minWidth: double.infinity),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                            ('$symptomName$groupName') ??
                                MyStyle().showProgress(),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontFamily: 'Prompt',
                            )),
                      ),
                    ]),
              ),
            ),
          )));
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
                  delsym2();
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
                              "ไม่มีอาการดังกล่าว/ไม่แน่ใจ",
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
