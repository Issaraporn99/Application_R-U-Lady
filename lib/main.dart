// import 'package:doctorpurin/screen/women_home.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';

// void main() {
//   Intl.defaultLocale = "th";
//   initializeDateFormatting();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(primaryColor: Colors.black, fontFamily: 'Prompt'),
//       home: WomenHome(),
//     );
//   }
// }

import 'package:doctorpurin/screen/disease/disease_info.dart';
import 'package:doctorpurin/screen/includes/article.dart';
import 'package:doctorpurin/screen/qa/showQA.dart';
import 'package:doctorpurin/screen/women_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

var tstyle = TextStyle(
    color: Colors.white.withOpacity(0.6), fontSize: 40, fontFamily: 'Prompt');

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var padding = EdgeInsets.symmetric(horizontal: 20, vertical: 5);
  double gap = 10;

  int _index = 0;
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        body: PageView(
          controller: controller,
          onPageChanged: (page) {
            setState(() {
              _index = page;
            });
          },
          children: [
            WomenHome(),
            DisInformation(),
            Article(),
            ShowQA(),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: -10,
                    blurRadius: 60,
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(0, 25),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: GNav(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 900),
                tabs: [
                  GButton(
                    gap: gap,
                    icon: LineIcons.home,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.pink,
                    text: 'หน้าแรก',
                    textStyle: TextStyle(color:Colors.pink, fontFamily: 'Prompt'),
                    backgroundColor: Colors.pink.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: LineIcons.hospital_o,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.purpleAccent,
                    text: 'โรค',
                    textStyle:
                        TextStyle(color: Colors.purpleAccent, fontFamily: 'Prompt'),
                    backgroundColor: Colors.purpleAccent.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: LineIcons.file,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.amber,
                    text: 'บทความ',
                    textStyle:
                        TextStyle(color: Colors.amber, fontFamily: 'Prompt'),
                    backgroundColor: Colors.amber.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                  ),
                  GButton(
                    gap: gap,
                    icon: LineIcons.question,
                    iconColor: Colors.black,
                    iconActiveColor: Colors.teal,
                    text: 'ถาม',
                    textStyle:
                        TextStyle(color: Colors.teal, fontFamily: 'Prompt'),
                    backgroundColor: Colors.teal.withOpacity(0.2),
                    iconSize: 24,
                    padding: padding,
                    
                  ),
                ],
                selectedIndex: _index,
                onTabChange: (index) {
                  setState(() {
                    _index = index;
                  });
                  controller.jumpToPage(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
