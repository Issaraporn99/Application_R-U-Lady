import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:doctorpurin/screen/check/showResult.dart';
import 'package:doctorpurin/utility/my_style.dart';
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
  String status;
  String yn;
  var diss = new List();
  List<GroupSym> strArr = List();
  var symm = new List();
  var ynn = new List();
  var statuss = new List();
  var symName = new List();

  var dis2 = new List();
  var sym2 = new List();
  var status2 = new List();
  var yn2 = new List();

  @override
  void initState() {
    super.initState();
    findId();
  }

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    symptomName = preferences.getString('symptom_name');
    symptomId = preferences.getString('symptom_id');
    diseaseId = preferences.getString('disease_id');
    yn = preferences.getString('yn');
    status = preferences.getString('status');

    String groupId = preferences.getString('group_id');

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym.php?group_id=$groupId&isAdd=true';
    await Dio().get(url).then((value) => {print('valueSSS = $value')});
    setState(() {
      symptomName = preferences.getString('symptom_name');
      yn = preferences.getString('yn');
      status = preferences.getString('status');
    });
  }

  Future<Null> idArray() async {
    String text = "";
    int cnum = diss.length;
    int i = 1;
    for (var x in diss) {
      if (i == cnum) {
        text = text + x;
      } else {
        text = text + x + ",";
      }
      i++;
    }
    print("ล่าสุด=$text");

    String text2 = "";
    int cnum2 = ynn.length;
    int i2 = 1;
    for (var x in ynn) {
      if (i2 == cnum2) {
        text2 = x;
      }
      i2++;
    }
    print("ล่าสุด=$text2");
    if (cnum == 1 && text2 == "a") {
      countyn();
    } else if (cnum == 1 && text2 == "y") {
      getDis();
    } else {
      setState(() {
        diss = [];
        symm = [];
        symName = [];
        sym2 = [];
        ynn = [];
      });

      String url =
          'http://student.crru.ac.th/601463046/apidoctor/apiSym2.php?symptom_id=$symptomId&isAdd=true';
      await Dio().get(url).then((value) => {print('idArray = $value')});
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      print("$result");
      setState(() {
        for (var x in result) {
          diss.add(x['disease_id']);
        }
        for (var x in result) {
          symm.add(x['symptom_id']);
        }
        for (var x in result) {
          statuss.add(x['status']);
        }
        for (var x in result) {
          ynn.add(x['yn']);
        }
      });

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
    int cnum2 = symm.length;
    int i2 = 1;
    int n2 = 0;
    for (var x2 in symm) {
      if (i2 == cnum2) {
        tt2 = tt2 + "symm[" + '$n2' + "]=" + x2;
      } else {
        tt2 = tt2 + "symm[" + '$n2' + "]=" + x2 + "&";
      }
      n2++;
      i2++;
    }

    String tt3 = "";
    int cnum3 = statuss.length;
    int i3 = 1;
    int n3 = 0;
    for (var x3 in statuss) {
      if (i3 == cnum3) {
        tt3 = tt3 + "statuss[" + '$n3' + "]=" + x3;
      } else {
        tt3 = tt3 + "statuss[" + '$n3' + "]=" + x3 + "&";
      }
      n3++;
      i3++;
    }

    String tt4 = "";
    int cnum4 = ynn.length;
    int i4 = 1;
    int n4 = 0;
    for (var x4 in ynn) {
      if (i4 == cnum4) {
        tt4 = tt4 + "ynn[" + '$n4' + "]=y";
      } else {
        tt4 = tt4 + "ynn[" + '$n4' + "]=y&";
      }
      n4++;
      i4++;
    }

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/updateYN.php?&$tt1&$tt2&$tt3&$tt4&isAdd=true';
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

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/delsym.php?&del=$del&isAdd=true';
    await Dio().get(url).then((value) => {print('del = $value')});
    Response response = await Dio().get(url);
    // var result = json.decode(response.data);

    coutsym();
  }

  Future<Null> coutsym() async {
    String text = "";
    int cnum = diss.length;
    int i = 1;
    for (var x in diss) {
      if (i == cnum) {
        text = text + x;
      } else {
        text = text + x + ",";
      }
      i++;
    }
    print("ล่าสุด=$text");

    String text2 = "";
    int cnum2 = ynn.length;
    int i2 = 1;
    for (var x in ynn) {
      if (i2 == cnum2) {
        text2 = x;
      }
      i2++;
    }
    print("ล่าสุด=$text2");
    if (cnum == 1 && text2 == "a") {
      countyn();
    } else if (cnum == 1 && text2 == "y") {
      getDis();
    } else {
      setState(() {
        symptomId = '';
        symptomName = '';
      });

      String url =
          'http://student.crru.ac.th/601463046/apidoctor/apiSym3.php?&text=$text&isAdd=true';
      await Dio().get(url).then((value) => {print('coutsym = $value')});
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      setState(() {
        for (var x in result) {
          symName.add(x['symptom_name']);
        }
        String sn = "";
        for (var s in symName) {
          sn = sn + s;
        }
        for (var x in result) {
          dis2.add(x['disease_id']);
        }
        for (var x in result) {
          sym2.add(x['symptom_id']);
        }
        String snn = "";
        for (var s in sym2) {
          snn = snn + s;
        }
        print(snn);
        for (var x in result) {
          status2.add(x['status']);
        }
        for (var x in result) {
          ynn.add(x['yn']);
        }
        print(sn);
        symptomName = sn;
        symptomId = snn;
      });
    }
  }

  Future<Null> getDis() async {
    Navigator.pop(context);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => ShowResult());
    Navigator.push(context, route);
  }

  Future<Null> countyn() async {
    setState(() {
      diss = [];
      symm = [];
      symName = [];
      sym2 = [];
      ynn = [];
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getYN.php?isAdd=true';
    await Dio().get(url).then((value) => {print('countyn = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    setState(() {
      for (var x in result) {
        diss.add(x['disease_id']);
      }
      for (var x in result) {
        symName.add(x['symptom_name']);
      }
      String sn = "";
      for (var s in symName) {
        sn = s;
      }

      for (var x in result) {
        symm.add(x['symptom_id']);
      }
      String snn = "";
      for (var s in symm) {
        snn = s;
      }
      print(snn);
      for (var x in result) {
        statuss.add(x['status']);
      }
      for (var x in result) {
        ynn.add(x['yn']);
      }
      String ym = "";
      for (var s in ynn) {
        ym = s;
      }
      print(sn);
      symptomName = sn;
      symptomId = snn;

      if (ym == "a") {
        updateYN2();
      } else {
        getDis();
      }
    });
  }

  Future<Null> updateYN2() async {
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
    int cnum2 = symm.length;
    int i2 = 1;
    int n2 = 0;
    for (var x2 in symm) {
      if (i2 == cnum2) {
        tt2 = tt2 + "symm[" + '$n2' + "]=" + x2;
      } else {
        tt2 = tt2 + "symm[" + '$n2' + "]=" + x2 + "&";
      }
      n2++;
      i2++;
    }

    String tt3 = "";
    int cnum3 = statuss.length;
    int i3 = 1;
    int n3 = 0;
    for (var x3 in statuss) {
      if (i3 == cnum3) {
        tt3 = tt3 + "statuss[" + '$n3' + "]=" + x3;
      } else {
        tt3 = tt3 + "statuss[" + '$n3' + "]=" + x3 + "&";
      }
      n3++;
      i3++;
    }

    String tt4 = "";
    int cnum4 = ynn.length;
    int i4 = 1;
    int n4 = 0;
    for (var x4 in ynn) {
      if (i4 == cnum4) {
        tt4 = tt4 + "ynn[" + '$n4' + "]=y";
      } else {
        tt4 = tt4 + "ynn[" + '$n4' + "]=y&";
      }
      n4++;
      i4++;
    }

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/updateYN.php?&$tt1&$tt2&$tt3&$tt4&isAdd=true';
    await Dio().get(url).then((value) => {print('updateYN2 = $value')});

    // getDis();
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
                  child: Text(('$symptomName') ?? "...",
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
