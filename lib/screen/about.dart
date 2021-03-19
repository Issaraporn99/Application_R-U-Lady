import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
//Field
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFBFA),
      appBar: AppBar(
        title: Text(
          ' เกี่ยวกับแอปพลิเคชัน',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30.0,
                width: 200.0,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: Image.asset(
                  './images/9786160446599l.jpg',
                  width:200,
                  
                ),
              ),
              Card(
                color: Colors.white,              
                child: Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: ListTile(
                    leading: Icon(
                      Icons.book,
                      color: Colors.red,
                    ),
                    title: Text(
                      'ข้อมูลในแอปพลิเคชั่นนี้อ้างอิงจาก หนังสือสุขภาพผู้หญิงตรวจเองได้ง่ายนิดเดียว',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontFamily: 'Prompt',
                      ),
                    )),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
