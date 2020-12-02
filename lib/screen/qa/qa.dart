import 'package:flutter/material.dart';
import 'package:doctorpurin/utility/my_style.dart';

class QandA extends StatefulWidget {
  @override
  _QandAState createState() => _QandAState();
}

class _QandAState extends State<QandA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ถาม-ตอบ กับผู้เชี่ยวชาญ'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, MyStyle().primaryColor],
            center: Alignment(0, -0.3),
            radius: 1.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().mySizeBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
