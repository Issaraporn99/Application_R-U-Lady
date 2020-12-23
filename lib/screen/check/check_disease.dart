import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:doctorpurin/screen/check/showGroup.dart';
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

  Future<Null> showG() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    setState(() {
      organId = ('1');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('value = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('res = $result');
      for (var map in result) {
        GroupSym groupInfo = GroupSym.fromJson(map);
        if (organId == groupInfo.organId) {
          routeTS(ShowGroup(), groupInfo);
        }
      }
    } catch (e) {}
  }

  Future<Null> showG2() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String organId = preferences.getString('organ_id');
    setState(() {
      organId = ('2');
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      //   // print('res = $response');

      var result = json.decode(response.data);
      //   // print('resShow = $result');
      for (var map in result) {
        GroupSym groupInfo = GroupSym.fromJson(map);
        if (organId == groupInfo.organId) {
          routeTS(ShowGroup(), groupInfo);
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTS(Widget myWidgett, GroupSym groupInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('group_id', groupInfo.groupId);
    preferences.setString('group_name', groupInfo.groupName);
    preferences.setString('organ_id', groupInfo.organId);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'คุณไม่สบายตรงไหน?',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.red[200],
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
                  Container(
                    height: 240,
                    child: InkWell(
                      onTap: showToast,
                    ),
                  ),
                  show1(),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      // color: Colors.green,
                      height: 145,
                      child: InkWell(
                        onTap: showToast2,
                      ),
                    ),
                  ),
                  show2(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // color: Colors.green,
                      height: 215,
                      child: InkWell(
                        onTap: showToast3,
                      ),
                    ),
                  ),
                  show3(),
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
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 70),
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
                    onTap: () {},
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
            margin: EdgeInsets.only(top: 35, right: 20),
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
                    onTap: () {},
                    // button pressed
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
            margin: EdgeInsets.only(top: 200, left: 10),
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
                    onTap: () {},
                    // button pressed
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
            margin: EdgeInsets.only(top: 120, left: 280),
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
                    onTap: () {},
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
            margin: EdgeInsets.only(top: 200, left: 260),
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
                    onTap: () {},
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
    );
  }

  Visibility show2() {
    return Visibility(
      visible: !_isVisible2,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 280, left: 15),
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
            margin: EdgeInsets.only(top: 205, left: 15),
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
                      // showG2();
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
            margin: EdgeInsets.only(top: 280, right: 15),
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
                    onTap: () {},
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
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 355, left: 15),
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
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ลำไส้",
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
            margin: EdgeInsets.only(top: 205, right: 15),
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
                    onTap: () {},
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
            margin: EdgeInsets.only(top: 355, right: 15),
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
                    onTap: () {},
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
    );
  }

  Visibility show3() {
    return Visibility(
      visible: !_isVisible3,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 360, left: 250),
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
            margin: EdgeInsets.only(top: 360, left: 20),
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
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "มือ",
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
            margin: EdgeInsets.only(top: 450, right: 55),
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
                    onTap: () {},
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
          Container(
            margin: EdgeInsets.only(top: 450, left: 50),
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
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ขา",
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
    );
  }
}
