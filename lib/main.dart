import 'package:doctorpurin/screen/women_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(
    primaryColor: Colors.purple[300],fontFamily: 'Prompt'),
      home: WomenHome(),
      
    );
  }
}
