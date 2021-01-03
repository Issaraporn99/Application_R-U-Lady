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
  String symptomName;

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
    String url =
        'http://192.168.1.108/apidoctor/getGroup.php?isAdd=true&organ_id=$organId';
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

  // Future<Null> showSym() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   symptomName = preferences.getString('symptom_name');
  //   String groupId = preferences.getString('group_id');

  //   String url =
  //       'http://student.crru.ac.th/601463046/apidoctor/apiSym.php?group_id=$groupId&isAdd=true';
  //   await Dio().get(url).then((value) => {print('valueSSS = $value')});
  //   try {
  //     Response response = await Dio().get(url);
  //     var result = json.decode(response.data);
  //     for (var map in result) {
  //       GroupSym sym = GroupSym.fromJson(map);
  //       setState(() {
  //         if (groupId == sym.groupId) {
  //           // routeTsS(ShowSym(), symInfo);
  //           print(groupId);
  //         }
  //       });
  //     }
  //   } catch (e) {}
  // }

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

  // SingleChildScrollView _dataBody() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.vertical,
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.vertical,
  //       child: DataTable(
  //         columns: [
  //           DataColumn(
  //             label: Text(
  //               "กลุ่ม ",
  //               style: TextStyle(fontFamily: 'Prompt'),
  //             ),
  //           ),
  //         ],
  //         rows: groupInfo
  //             .map(
  //               (article) => DataRow(
  //                 cells: [
  //                   DataCell(
  //                     Text(
  //                       article.groupName,
  //                       style: TextStyle(fontFamily: 'Prompt'),
  //                     ),
  //                     onTap: () {
  //                       print("ID " + article.groupId);
  //                       routeTsS(ShowSym(), article);
  //                     },
  //                   ),
  //                 ],
  //               ),
  //             )
  //             .toList(),
  //       ),
  //     ),
  //   );
  // }

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
                                    routeTsS(ShowSym(),  groupInfo[index]);
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

//         body: groupInfo.length == 0
//             ? MyStyle().showProgress()
//             : ListView.builder(
//                 itemCount: groupInfo.length,
//                 itemBuilder: (context, index) => Padding(
//                       padding: const EdgeInsets.all(5),
//                       child: SizedBox(
//                         height: 70,
//                         child: Card(
//                           elevation: 1.5,
//                           color: Colors.white,
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.only(left: 15, top: 17),
//                                 child: InkWell(
//                                   splashColor: Colors.white,
//                                   // splash color
//                                   onTap: () {
//                                     showSym();
//                                     print(groupInfo[index].groupName);
//                                   },
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         groupInfo[index].groupName,
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontFamily: 'Prompt'),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     )));
//   }
// }
