import 'package:dio/dio.dart';
import 'package:doctorpurin/main.dart';
import 'package:doctorpurin/modal/question_modal.dart';
import 'package:doctorpurin/screen/qa/qa.dart';
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
        backgroundColor: Colors.pinkAccent[100],
      ),
      backgroundColor: Colors.white,
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
                    "คุณยังไม่มีแนวโน้มที่จะเป็นโรค",
                    style: TextStyle(
                      color: Colors.teal[300],
                      fontFamily: 'Prompt',
                      fontSize: 20.0,
                    ),
                  ),
                ),
                MyStyle().rr(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 10),
                  child: Text(
                    "หมายเหตุ : หากคุณมีอาการผิดปกติ ควรปรึกษาแพทย์ผู้เชี่ยวชาญ",
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Prompt',
                      fontSize: 16.0,
                    ),
                  ),
                ),
                // button(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent[100],
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
        child: Icon(Icons.home),
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: RaisedButton(
                onPressed: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) => QandA());
                  Navigator.push(context, route);
                },
                color: Color(0xFF6ddccf),
                elevation: 8,
                child: Text(
                  'สอบถามผู้เชี่ยวชาญ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontFamily: 'Prompt',
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
