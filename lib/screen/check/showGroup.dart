import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
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
        'http://192.168.1.108/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
    await Dio().get(url).then((value) => {print('value = $value')});

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
                          color: Colors.white60,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 17),
                                child: InkWell(
                                  splashColor: Colors.white,
                                  // splash color
                                  onTap: () {
                                    print(groupInfo[index].groupName);
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
