import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:doctorpurin/modal/sym_modal.dart';
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

  List<GroupSym> groupInfo = List();
  @override
  void initState() {
    super.initState();
    findId();
  }

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    organId = preferences.getString('organ_id');
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

  Future<Null> showSym() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String groupId = preferences.getString('group_id');

    String url =
        'http://192.168.1.108/apidoctor/getSym.php?group_id=$groupId&isAdd=true';
    await Dio().get(url).then((value) => {print('valueaa = $value')});
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      for (var map in result) {
        SymModal sym = SymModal.fromJson(map);
        if (groupId == sym.groupId) {
          routeTS(ShowSym(), sym);
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTS(Widget myWidgett, SymModal sym) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('group_id', sym.groupId);
    preferences.setString('symptom_name', sym.symptomName);
    preferences.setString('symptom_id', sym.symptomId);
    preferences.setString('disease_id', sym.diseaseId);
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
            'คุณไม่สบายตรงไหน?',
            style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
          ),
          backgroundColor: Colors.red[200],
        ),
        body: groupInfo.length == 0
            ? MyStyle().showProgress()
            : ListView.builder(
                itemCount: groupInfo.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        height: 70,
                        child: Card(
                          elevation: 1.5,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 17),
                                child: InkWell(
                                  splashColor: Colors.white,
                                  // splash color
                                  onTap: () {       

                                    MaterialPageRoute route = MaterialPageRoute(
                                        builder: (context) => ShowSym());
                                    Navigator.push(context, route);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        groupInfo[index].groupName,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Prompt'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )));
  }
}
