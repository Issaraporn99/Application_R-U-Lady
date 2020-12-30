import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:doctorpurin/modal/sym_modal.dart';
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

  @override
  void initState() {
    super.initState();
    findId();
  }

  // Future<Null> findId() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     symptomName = preferences.getString('symptom_name');
  //     groupId = preferences.getString('group_id');
  //   });
  // }

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    symptomName = preferences.getString('symptom_name');
    String groupId = preferences.getString('group_id');

    String url =
        'http://192.168.100.5/apidoctor/apiSym.php?group_id=$groupId&isAdd=true';
    await Dio().get(url).then((value) => {print('valueSSS = $value')});
    setState(() {
      symptomName = preferences.getString('symptom_name');
    });
  }

  // Future<Null> routeTS(Widget myWidgett, SymModal sym) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('group_id', sym.groupId);
  //   preferences.setString('symptom_name', sym.symptomName);
  //   preferences.setString('symptom_id', sym.symptomId);
  //   preferences.setString('disease_id', sym.diseaseId);
  //   // Navigator.pop(context);
  //   MaterialPageRoute route =
  //       MaterialPageRoute(builder: (context) => myWidgett);
  //   Navigator.push(context, route);
  // }

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
//                                     // showSym();
//                                   },
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         groupInfo[index].symptomName,
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
                  child: Text('$symptomName',
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
                        onPressed: () {},
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
