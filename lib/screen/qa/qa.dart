import 'package:dio/dio.dart';
import 'package:doctorpurin/utility/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:doctorpurin/utility/my_style.dart';

class QandA extends StatefulWidget {
  @override
  _QandAState createState() => _QandAState();
}

class _QandAState extends State<QandA> {
   List _typeEx = [
    "1",
    "2",
  ];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  // String _currentType;
@override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    expertiseId = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String typeEx in _typeEx) {
      items.add(new DropdownMenuItem(value: typeEx, child: new Text(typeEx)));
    }
    return items;
  }

  void changedDropDownItem(String selectedEx) {
    setState(() {
      expertiseId = selectedEx;
    });
  }
  String questionId;
  String question;
  String questionDate;
  String questionName;
  String expertiseId;
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
                userForm(),
                qustion(),
                questiondate(),
                MyStyle().showTitleH2('เลือกประเภทของผู้เชี่ยวชาญ :'),
          new DropdownButton(
            value: expertiseId,
            items: _dropDownMenuItems,
            onChanged: changedDropDownItem,
          ),
                registerButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registerButton() => Container(
      width: 250.0,
      child: RaisedButton(
        color: MyStyle().darkColor,
        onPressed: () {
          print(
              'question = $question, question_name = $questionName, expertise_id = $expertiseId,question_date=$questionDate');
          registerThread();
        },
        child: Text('Register',
            style: TextStyle(
              color: Colors.white,
            )),
      ));

  Future<Null> registerThread() async {
    String url =
        'http://192.168.1.108/apidoctor/addQustion.php?isAdd=true&question=$question&question_name=$questionName&expertise_id=$expertiseId&question_date=$questionDate';

    try {
      Response response = await Dio().get(url);
      print('res=$response');

      if (response.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่');
      }
    } catch (e) {}
  }

  Widget qustion() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 250.0,
              child: TextField(
                onChanged: (value) => question = value.trim(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.face,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'question :',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().primaryColor)),
                ),
              )
              ),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 250.0,
              child: TextField(
                onChanged: (value) => questionName = value.trim(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_box,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'ชื่อ :',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().primaryColor)),
                ),
              )),
        ],
      );
        Widget questiondate() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 250.0,
              child: TextField(
                onChanged: (value) => questionDate = value.trim(),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.account_box,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'ชื่อ :',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().darkColor)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: MyStyle().primaryColor)),
                ),
              )),
        ],
      );

}
