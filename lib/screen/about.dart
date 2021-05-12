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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'เกี่ยวกับแอปพลิเคชัน',
                  style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
                )),
            Image.asset(
              './images/Untitled-1.png',
              fit: BoxFit.contain,
              height: 40,
            )
          ],
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
                height: 10.0,
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
                  width: 200,
                ),
              ),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  child: ListTile(
                      leading: Icon(
                        Icons.book,
                        color: Colors.red,
                      ),
                      title: Text(
                        'ข้อมูลในแอปพลิเคชันนี้อ้างอิงจาก หนังสือสุขภาพผู้หญิงตรวจเองได้ง่ายนิดเดียว (ผู้เขียน Akiyoshi Uchiyama, 2560)',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontFamily: 'Prompt',
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
