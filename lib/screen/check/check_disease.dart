import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:doctorpurin/screen/check/showGroup.dart';
import 'package:doctorpurin/utility/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckDisease extends StatefulWidget {
  @override
  _CheckDiseaseState createState() => _CheckDiseaseState();
}

class _CheckDiseaseState extends State<CheckDisease> {
  bool _isVisible = true;
  bool _isVisible2 = true;
  bool _isVisible3 = true;
  bool _isVisible4 = true;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
      _isVisible2 = true;
      _isVisible3 = true;
    });
  }

  void showToast2() {
    setState(() {
      _isVisible2 = !_isVisible2;
      _isVisible = true;
      _isVisible3 = true;
    });
  }

  void showToast3() {
    setState(() {
      _isVisible3 = !_isVisible3;
      _isVisible2 = true;
      _isVisible = true;
    });
  }

  void showToast4() {
    setState(() {
      _isVisible4 = !_isVisible4;
    });
  }

  @override
  void initState() {
    super.initState();
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
  Future<Null> showG() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('1');
      organName = ('เต้านม');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('value = $value')});
    try {
      Response response = await Dio().get(url);
      // print('res = $response');

      var result = json.decode(response.data);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ShowGroup()));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('organ_id', organId);
      preferences.setString('organ_name', organName);
      // print('res = $result');
      // for (var map in result) {
      //   GroupSym groupInfo = GroupSym.fromJson(map);
      //   if (organId == groupInfo.organId) {
      //     routeTS(ShowGroup(), groupInfo);
      //   }
      // }
    } catch (e) {}
  }

  Future<Null> showG2() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('2');
      organName = ('อวัยวะสืบพันธุ์');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('res = $result');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ShowGroup()));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('organ_id', organId);
      preferences.setString('organ_name', organName);
    } catch (e) {}
  }

  Future<Null> showG3() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('3');
      organName = ('ศีรษะ');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('res = $result');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ShowGroup()));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('organ_id', organId);
      preferences.setString('organ_name', organName);
    } catch (e) {}
  }

  Future<Null> showG4() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('4');

      organName = ('หู');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        normalDialog2(context, 'ยังไม่มีข้อมูล');
      } else {
        var result = json.decode(response.data);
        print('res = $result');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowGroup()));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('organ_id', organId);
        preferences.setString('organ_name', organName);
      }
    } catch (e) {}
  }

  Future<Null> showG5() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('5');
      organName = ('ตา');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        normalDialog2(context, 'ยังไม่มีข้อมูล');
      } else {
        var result = json.decode(response.data);
        print('res = $result');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowGroup()));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('organ_id', organId);
        preferences.setString('organ_name', organName);
      }
    } catch (e) {}
  }

  Future<Null> showG6() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('6');
      organName = ('จมูก');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        normalDialog2(context, 'ยังไม่มีข้อมูล');
      } else {
        var result = json.decode(response.data);
        print('res = $result');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowGroup()));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('organ_id', organId);
        preferences.setString('organ_name', organName);
      }
    } catch (e) {}
  }

  Future<Null> showG7() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('7');
      organName = ('ปาก');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        normalDialog2(context, 'ยังไม่มีข้อมูล');
      } else {
        var result = json.decode(response.data);
        print('res = $result');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowGroup()));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('organ_id', organId);
        preferences.setString('organ_name', organName);
      }
    } catch (e) {}
  }

  Future<Null> showG8() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('8');
      organName = ('คอ');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('res = $result');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ShowGroup()));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('organ_id', organId);
      preferences.setString('organ_name', organName);
    } catch (e) {}
  }

  Future<Null> showG9() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('9');
      organName = ('ไหล่');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        normalDialog2(context, 'ยังไม่มีข้อมูล');
      } else {
        var result = json.decode(response.data);
        print('res = $result');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowGroup()));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('organ_id', organId);
        preferences.setString('organ_name', organName);
      }
    } catch (e) {}
  }

  Future<Null> showG10() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('10');
      organName = ('เอว');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        normalDialog2(context, 'ยังไม่มีข้อมูล');
      } else {
        var result = json.decode(response.data);
        print('res = $result');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowGroup()));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('organ_id', organId);
        preferences.setString('organ_name', organName);
      }
    } catch (e) {}
  }

  Future<Null> showG11() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('11');
      organName = ('กระเพาะและลำไส้');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        normalDialog2(context, 'ยังไม่มีข้อมูล');
      } else {
        var result = json.decode(response.data);
        print('res = $result');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowGroup()));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('organ_id', organId);
        preferences.setString('organ_name', organName);
      }
    } catch (e) {}
  }

  Future<Null> showG12() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    setState(() {
      organId = ('12');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);

      for (var map in result) {
        GroupSym groupInfo = GroupSym.fromJson(map);
        if (organId == groupInfo.organId) {
          routeTS(ShowGroup(), groupInfo);
        }
      }
    } catch (e) {}
  }

  Future<Null> showG13() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('12');
      organName = ('อก');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        normalDialog2(context, 'ยังไม่มีข้อมูล');
      } else {
        var result = json.decode(response.data);
        print('res = $result');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowGroup()));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('organ_id', organId);
        preferences.setString('organ_name', organName);
      }
    } catch (e) {}
  }

  Future<Null> showG14() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('14');
      organName = ('มือและขา');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('res = $result');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ShowGroup()));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('organ_id', organId);
      preferences.setString('organ_name', organName);
    } catch (e) {}
  }

  Future<Null> showG15() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    setState(() {
      organId = ('15');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);

      for (var map in result) {
        GroupSym groupInfo = GroupSym.fromJson(map);
        if (organId == groupInfo.organId) {
          routeTS(ShowGroup(), groupInfo);
        }
      }
    } catch (e) {}
  }

  Future<Null> showG16() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    String organName = preferences.getString('organ_name');
    setState(() {
      organId = ('16');
      organName = ('ผิว');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        normalDialog2(context, 'ยังไม่มีข้อมูล');
      } else {
        var result = json.decode(response.data);
        print('res = $result');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowGroup()));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('organ_id', organId);
        preferences.setString('organ_name', organName);
      }
    } catch (e) {}
  }

  Future<Null> routeTS(Widget myWidgett, GroupSym groupInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('group_id', groupInfo.groupId);
    preferences.setString('group_name', groupInfo.groupName);
    preferences.setString('organ_id', groupInfo.organId);
    preferences.setString('organ_name', groupInfo.organName);
    // Navigator.pop(context);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'กดเลือกอวัยวะที่ต้องการตรวจ',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Prompt',
                      fontSize: 16.0),
                )),
            Image.asset(
              './images/Untitled-1.png',
              fit: BoxFit.contain,
              height: 40,
            )
          ],
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/body.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 240,
                      width: 220,
                      child: InkWell(
                        onTap: showToast,
                      ),
                    ),
                  ),
                  show1(),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 160,
                      width: 200,
                      child: InkWell(
                        onTap: showToast2,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 220,
                        child: Stack(children: <Widget>[
                          show2(),
                        ]),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 220,
                      width: 200,
                      child: InkWell(
                        onTap: showToast3,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: 220,
                        child: Stack(children: <Widget>[
                          show3(),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Visibility show1() {
    return Visibility(
      visible: !_isVisible,
      child: Material(
        color: Colors.pink[50].withOpacity(0.5),
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              alignment: Alignment.topLeft,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG5();
                      },
                      // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ตา",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, right: 2),
              alignment: Alignment.topRight,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG3();
                      },

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ศีรษะ",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 180, left: 1),
              alignment: Alignment.centerLeft,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG4();
                      },

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "หู",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              alignment: Alignment.centerRight,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG6();
                      },
                      // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "จมูก",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 180, left: 280),
              alignment: Alignment.centerRight,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG7();
                      },
                      // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ปาก",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Visibility show2() {
    return Visibility(
      visible: !_isVisible2,
      child: Material(
        color: Colors.pink[50].withOpacity(0.5),
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 15),
              alignment: Alignment.topLeft,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG();
                      },
                      // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "เต้านม",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 75, left: 15),
              alignment: Alignment.topLeft,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG8();
                      },
                      // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "คอ",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15),
              alignment: Alignment.centerRight,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG11();
                      },
                      // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "กระเพาะ",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ),
                          Text(
                            "ลำไส้",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 150, left: 15),
              alignment: Alignment.centerLeft,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG13();
                      },
                      // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "อก",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 75, right: 15),
              alignment: Alignment.centerRight,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG9();
                      },
                      // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ไหล่",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 150, right: 15),
              alignment: Alignment.centerRight,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG10();
                      },
                      // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "เอว",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Visibility show3() {
    return Visibility(
      visible: !_isVisible3,
      child: Material(
        color: Colors.pink[50].withOpacity(0.5),
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30, right: 20),
              alignment: Alignment.bottomRight,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG2();
                      },
                      // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "อวัยวะ",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ),
                          Text(
                            "สืบพันธุ์",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 20),
              alignment: Alignment.bottomLeft,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG14();
                      },
                      // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "มือและขา",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 120, right: 20),
              alignment: Alignment.bottomRight,
              height: 70.0,
              child: SizedBox.fromSize(
                size: Size(70, 70), // button width and height
                child: ClipOval(
                  child: Material(
                    color: Colors.cyan[300], // button color
                    child: InkWell(
                      splashColor: Colors.lime[200],
                      // splash color
                      onTap: () {
                        showG16();
                      },
                      // button pressed
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "ผิว",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: 'Prompt'),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
