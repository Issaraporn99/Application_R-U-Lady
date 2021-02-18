import 'package:dio/dio.dart';
import 'package:doctorpurin/main.dart';
import 'package:doctorpurin/utility/my_style.dart';
import 'package:flutter/material.dart';

class ShowResult2 extends StatefulWidget {
  @override
  _ShowResult2State createState() => _ShowResult2State();
}

class _ShowResult2State extends State<ShowResult2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ผลการตรวจโรค',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.red[200],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "คุณสบายดี !!",
                    style: TextStyle(
                      color: Colors.lightBlueAccent[700],
                      fontFamily: 'Prompt',
                      fontSize: 25.0,
                    ),
                  ),
                ),
                MyStyle().rr(),
                button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future<Null> del() async {
  //   String url =
  //       'http://student.crru.ac.th/601463046/apidoctor/deleteGetdis.php?&isAdd=true';
  //   await Dio().get(url).then((value) => {print('del = $value')});
  //   Response response = await Dio().get(url);
  // }

  Widget button() => Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 200,
            height: 50,
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (context) => MyApp());
                Navigator.push(context, route);
              },
              color: Color(0xFF214151),
              elevation: 8,
              child: Text(
                'ดูข้อมูลอื่น ๆ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontFamily: 'Prompt',
                ),
              ),
            ),
          ),
        ),
      );
}
