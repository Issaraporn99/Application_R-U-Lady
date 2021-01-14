import 'package:flutter/material.dart';

class ShowResult extends StatefulWidget {
  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ผลการตรวจโรค',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.red[200],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text('คุณมีแนวโน้มที่จะเป็นโรค..',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontFamily: 'Prompt',
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
