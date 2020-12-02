import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowDis extends StatefulWidget {
  @override
  _ShowDisState createState() => _ShowDisState();
}

class _ShowDisState extends State<ShowDis> {  
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
          title: Text('ข้อมูลโรค'),
        ),
        body: Container(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                nameDis(),
                showDetail(),
                showCause(),
                showTreatment(),
                showDefence(),
                showData(),
                showAbout(),
                // showList(),
                // showList2(),
                // showList3(),
                // showList4(),
              ],
            ),
          )),
        ));
  }

  Widget nameDis() => Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'โรค $diseasename',
            style: TextStyle(
              color: Colors.blue[900],
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
              if ('$diseasetreatment' != '')
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Text('       $diseasetreatment'),
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
              if ('$diseasedefence' != '')
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
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
            if ('$diseasecause' != '')
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
            if ('$diseaseabout' != '')
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
                  padding: const EdgeInsets.only(left: 20),
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
                  padding: const EdgeInsets.only(left: 40),
                  child: Text('$diseaserisk'),
                ),
              ),
              if ('$diseasechance' != '')
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
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
                  padding: const EdgeInsets.only(left: 40),
                  child: Text('$diseasechance'),
                ),
              ),
              // if ('$expertiseid' != '')
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
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
