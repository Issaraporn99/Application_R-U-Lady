import 'package:doctorpurin/screen/disease/diseaseBody.dart';
import 'package:doctorpurin/screen/disease/disease_info.dart';
import 'package:doctorpurin/utility/my_style.dart';
import 'package:flutter/material.dart';

class DiseaseMenu extends StatefulWidget {
  @override
  _DiseaseMenuState createState() => _DiseaseMenuState();
}

class _DiseaseMenuState extends State<DiseaseMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลเกี่ยวกับโรค'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyStyle().mySizeBox(),
                MyStyle().mySizeBox(),
                diseaseInfoButton(),
                MyStyle().mySizeBox(),
                diseaseBodyButton(),
              ],
            ),
          ),
        ),
    );
  }

  Widget diseaseInfoButton() => Container(
        child: SizedBox(
          width: 270,
          height: 80,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DisInformation()));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            color: Color(0xFF07456F),
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  './images/search.png',
                  width: 65,
                  height: 65,
                ),
                Expanded(
                  child: Text(
                    'ค้นหาโรคทั้งหมด',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget diseaseBodyButton() => Container(
        child: SizedBox(
          width: 270,
          height: 80,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DiseaseBody()));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            color: Color(0xFF009F9D),
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  './images/bodydis.png',
                  width: 65,
                  height: 65,
                ),
                Expanded(
                  child: Text(
                    'ค้นหาโรคตามอวัยวะ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
