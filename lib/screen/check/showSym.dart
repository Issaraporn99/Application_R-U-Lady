

import 'package:dio/dio.dart';
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

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    symptomName = preferences.getString('symptom_name');
    String groupId = preferences.getString('group_id');

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym.php?group_id=$groupId&isAdd=true';
    await Dio().get(url).then((value) => {print('valueSSS = $value')});
    setState(() {
      symptomName = preferences.getString('symptom_name');
    });
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
                  child: Text(
                    '$symptomName',
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
