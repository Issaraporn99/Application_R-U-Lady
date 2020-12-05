import 'package:doctorpurin/screen/women_home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
class ShowDis extends StatefulWidget {
  @override
  _ShowDisState createState() => _ShowDisState();
}

class _ShowDisState extends State<ShowDis> {
  final CarouselController _controller = CarouselController();
  String diseaseid;
  String diseasename;
  String diseasedetail;
  String diseasecause;
  String diseaserisk;
  String diseasechance;
  String diseasetreatment;
  String diseasedefence;
  String diseaseabout;
  String expertiseid;
  String expertisename;
  @override
  void initState() {
    super.initState();
    findId();
  }

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      diseaseid = preferences.getString('disease_id');
      diseasename = preferences.getString('disease_name');
      diseasedetail = preferences.getString('disease_detail');
      diseasecause = preferences.getString('disease_cause');
      diseaserisk = preferences.getString('disease_risk');
      diseasechance = preferences.getString('disease_chance');
      diseasetreatment = preferences.getString('disease_treatment');
      diseasedefence = preferences.getString('disease_defence');
      diseaseabout = preferences.getString('disease_about');
      expertiseid = preferences.getString('expertise_id');
      expertisename = preferences.getString('expertise_name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ข้อมูลโรค '),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 5),
                child: Text(
                  'โรค $diseasename',
                  style: TextStyle(
                    color: Colors.purple[300],
                    fontSize: 18.0,
                  ),
                ),
              ),
              CarouselSlider(
                items: [
                  showDetail(),
                  showCause(),
                  showTreatment(),
                  showDefence(),
                  showData(),
                  showAbout()
                ],
                options: CarouselOptions(enlargeCenterPage: true, height: 400),
                carouselController: _controller,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20),
                    child: FlatButton(
                      onPressed: () => _controller.previousPage(),
                      child: Image.asset(
                        'images/pre.png',
                        width: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only( bottom: 20),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WomenHome()));
                      },
                      child: Image.asset(
                        'images/btnh.png',
                        width: 60,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20),
                    child: FlatButton(
                      onPressed: () => _controller.nextPage(),
                      child: Image.asset(
                        'images/next.png',
                        width: 30,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget nameDis() => Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'โรค $diseasename',
            style: TextStyle(
              color: Color(0xFF45046a),
              fontSize: 18.0,
            ),
          ),
        ),
      );
  Widget showTreatment() => Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'การรักษา',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text('$diseasetreatment'),
              ),
            ],
          ),
        ),
      );
  Widget showDefence() => Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'การป้องกัน',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text('       $diseasedefence'),
              ),
            ],
          ),
        ),
      );
  Widget showCause() => Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'สาเหตุ',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Text('       $diseasecause'),
              ),
            ],
          ),
        ),
      );

  Widget showDetail() => Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'อาการ',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Text('       $diseasedetail'),
              ),
            ],
          ),
        ),
      );

  Widget showAbout() => Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'หมายเหตุ',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Text('       $diseaseabout'),
              ),
            ],
          ),
        ),
      );

  Widget showData() => Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'ข้อมูลทั่วไป',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 16.0,
                  ),
                ),
              ),
              if ('$diseaserisk' != '')
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Text(
                      'กลุ่มเสี่ยง',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40,right: 20),
                  child: Text('$diseaserisk'),
                ),
              ),
              if ('$diseasechance' != '')
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Text(
                      'โอกาสเกิด',
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40,right: 20),
                  child: Text('$diseasechance'),
                ),
              ),
              // if ('$expertiseid' != '')
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Text(
                    'ควรพบแพทย์สาขา',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, bottom: 20),
                  child: Text('$expertisename'),
                ),
              ),
            ],
          ),
        ),
      );

  Widget showList() => Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'รายละเอียด',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 16.0,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => showDetail(),
                    ),
                  );
                },
                leading: Icon(Icons.navigate_next),
              ),
            ],
          ),
        ),
      );
  Widget showList2() => Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'สาเหตุ',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 16.0,
                  ),
                ),
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (value) => showCause());
                  Navigator.push(context, route);
                },
                leading: Icon(Icons.navigate_next),
              ),
            ],
          ),
        ),
      );
  Widget showList3() => Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'เกี่ยวกับโรคเพิ่มเติม',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 16.0,
                  ),
                ),
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (value) => showAbout());
                  Navigator.push(context, route);
                },
                leading: Icon(Icons.navigate_next),
              ),
            ],
          ),
        ),
      );
  Widget showList4() => Container(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'ข้อมูลทั่วไป',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 16.0,
                  ),
                ),
                onTap: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (value) => showData());
                  Navigator.push(context, route);
                },
                leading: Icon(Icons.navigate_next),
              ),
            ],
          ),
        ),
      );
}
