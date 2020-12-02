import 'package:flutter/material.dart';

class DiseaseBody extends StatefulWidget {
  @override
  _DiseaseBodyState createState() => _DiseaseBodyState();
}

class _DiseaseBodyState extends State<DiseaseBody> {
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
        title: Text('ค้นหาโรคตามอวัยวะ'),
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
            ListView(
              children: <Widget>[
                container1(),
                show1(),
                container2(),
                show2(),
                container3(),
                show3(),
                container4(),
                show4(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector container4() {
    return new GestureDetector(
      child: new Container(
        color: Colors.green,
        height: 120,
        child: InkWell(
          onTap: showToast4,
        ),
      ),
    );
  }

  GestureDetector container3() {
    return new GestureDetector(
      child: new Container(
        color: Colors.red,
        height: 120,
        child: InkWell(
          onTap: showToast3,
        ),
      ),
    );
  }

  GestureDetector container2() {
    return new GestureDetector(
      child: new Container(
        color: Colors.orange,
        height: 50,
        child: InkWell(
          onTap: showToast2,
        ),
      ),
    );
  }

  GestureDetector container1() {
    return new GestureDetector(
      child: new Container(
        color: Colors.blue,
        height: 190,
        child: InkWell(
          // onTap: () => print("1"),
          onTap: showToast,
        ),
      ),
    );
  }

  Visibility show1() {
    return Visibility(
      visible: !_isVisible,
      child: Card(
        child: new ListTile(
          title: Center(
            child: new Text('1'),
          ),
        ),
      ),
    );
  }

  Visibility show2() {
    return Visibility(
      visible: !_isVisible2,
      child: Card(
        child: new ListTile(
          title: Center(
            child: new Text('2'),
          ),
        ),
      ),
    );
  }

  Visibility show3() {
    return Visibility(
      visible: !_isVisible3,
      child: Card(
        child: new ListTile(
          title: Center(
            child: new Text('3'),
          ),
        ),
      ),
    );
  }

  Visibility show4() {
    return Visibility(
      visible: !_isVisible4,
      child: RaisedButton(
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => ShowDis()));
        },
        color: Color(0xFF07456F),
        child: Text(
          'ศีรษะ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }
}
