import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:doctorpurin/screen/check/showSym.dart';
import 'package:doctorpurin/utility/my_style.dart';
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
    print('res = $result');
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
    // Navigator.pop(context);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
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
                  print(groupInfo[index].groupName);
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
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 70,
              child: InkWell(
                splashColor: Colors.white,
                onTap: () {
                  print("ไม่ทราบ");
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
