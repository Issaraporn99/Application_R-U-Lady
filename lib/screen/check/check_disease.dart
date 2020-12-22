import 'package:flutter/material.dart';

class CheckDisease extends StatefulWidget {
  @override
  _CheckDiseaseState createState() => _CheckDiseaseState();
}

class _CheckDiseaseState extends State<CheckDisease> {
  bool _isVisible = true;
  bool _isVisible2 = true;
  bool _isVisible3 = true;
  bool _isVisible4 = true;

  void showToast() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void showToast2() {
    setState(() {
      _isVisible2 = !_isVisible2;
    });
  }

  void showToast3() {
    setState(() {
      _isVisible3 = !_isVisible3;
    });
  }

  void showToast4() {
    setState(() {
      _isVisible4 = !_isVisible4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'คุณไม่สบายตรงไหน?',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.red[200],
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/body.png'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 240,
                    child: InkWell(
                      onTap: showToast,
                    ),
                  ),
                  show1(),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      // color: Colors.green,
                      height: 145,
                      child: InkWell(
                        onTap: showToast2,
                      ),
                    ),
                  ),
                  show2(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // color: Colors.green,
                      height: 215,
                      child: InkWell(
                        onTap: showToast3,
                      ),
                    ),
                  ),
                  show3(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget container1() => Container(
        child: Container(
          child: InkWell(
            // onTap: () => print("1"),
            onTap: showToast,
          ),
        ),
      );

  Visibility show1() {
    return Visibility(
      visible: !_isVisible,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50),
            alignment: Alignment.topLeft,
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ตา",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, right: 20),
            alignment: Alignment.topRight,
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ศีรษะ",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 170,
            ),
            alignment: Alignment.centerLeft,
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "หู",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 120, left: 280),
            alignment: Alignment.centerLeft,
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "จมูก",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 200, left: 280),
            alignment: Alignment.centerLeft,
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ปาก",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Visibility show2() {
    return Visibility(
      visible: !_isVisible2,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 250, left: 30),
            alignment: Alignment.topLeft,
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {
                      print('เต้านม');
                    },
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "เต้านม",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 305, left: 250),
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "กระเพาะ",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 330, left: 25),
            alignment: Alignment.centerLeft,
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ลำไส้",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 230, left: 250),
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ไหล่",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 375, left: 230),
            alignment: Alignment.centerLeft,
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "เอว",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Visibility show3() {
    return Visibility(
      visible: !_isVisible3,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 375, left: 230),
            height: 80.0,
            child: SizedBox.fromSize(
              size: Size(100, 100), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "อวัยวะสืบพันธุ์",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 360, left: 10),
            alignment: Alignment.centerLeft,
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "มือ",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 460, right: 70),
            alignment: Alignment.bottomRight,
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ผิว",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 450, left: 50),
            alignment: Alignment.centerLeft,
            height: 70.0,
            child: SizedBox.fromSize(
              size: Size(70, 70), // button width and height
              child: ClipOval(
                child: Material(
                  color: Colors.cyan[300], // button color
                  child: InkWell(
                    splashColor: Colors.lime[200],
                    // splash color
                    onTap: () {},
                    // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "ขา",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'Prompt'),
                        ), // text
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
