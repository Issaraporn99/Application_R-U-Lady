import 'package:flutter/material.dart';

class CheckDisease extends StatefulWidget {
  @override
  _CheckDiseaseState createState() => _CheckDiseaseState();
}

class _CheckDiseaseState extends State<CheckDisease> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('คุณไม่สบายตรงไหน?'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/body.png'),
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
