import 'package:flutter/material.dart';

//popup
//ถ้า popup ขึ้น ให้ state หยุดทำงาน
Future<void> normalDialog(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(message),
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.red),
                )),
          ],
        )
      ],
    ),
  );
}
