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
              padding: const EdgeInsets.all(25.0),
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink,
            ),
            width: 64,
            height: 64,
            child: ClipOval(
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () {
                    print('Tapped!');
                  },
                  child: Text(
                    'หู',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: RaisedButton(
                onPressed: () {
                  print('หู');
                },
                color: Color(0xFF07456F),
                child: Text(
                  'หู',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
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
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: RaisedButton(
                onPressed: () {
                  print('ศีรษะ');
                },
                color: Color(0xFF07456F),
                child: Text(
                  'sss',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: RaisedButton(
                onPressed: () {
                  print('ศีรษะ');
                },
                color: Color(0xFF07456F),
                child: Text(
                  'ddddd',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
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
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: RaisedButton(
                onPressed: () {
                  print('3');
                },
                color: Color(0xFF07456F),
                child: Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: RaisedButton(
                onPressed: () {
                  print('3');
                },
                color: Color(0xFF07456F),
                child: Text(
                  '333',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.0,
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
