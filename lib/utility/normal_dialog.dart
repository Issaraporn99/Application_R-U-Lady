import 'package:doctorpurin/screen/includes/article.dart';
import 'package:flutter/material.dart';

//popup
//ถ้า popup ขึ้น ให้ state หยุดทำงาน
Future<void> normalDialog(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(
        message,
        style: TextStyle(fontSize: 15.0, fontFamily: 'Prompt'),
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Article())),
                child: Text(
                  'ดูบทความอื่น ๆ',
                  style: TextStyle(color: Colors.blue, fontFamily: 'Prompt'),
                )),
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'ปิด',
                  style: TextStyle(color: Colors.red, fontFamily: 'Prompt'),
                )),
          ],
        )
      ],
    ),
  );
}

Future<void> normalDialog2(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(
        message,
        style: TextStyle(fontSize: 15.0, fontFamily: 'Prompt'),
      ),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'ปิด',
                  style: TextStyle(color: Colors.red, fontFamily: 'Prompt'),
                )),
          ],
        )
      ],
    ),
  );
}
