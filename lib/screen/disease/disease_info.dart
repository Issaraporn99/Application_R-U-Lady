import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/screen/disease/service.dart';
import 'package:doctorpurin/screen/disease/showdis.dart';
import 'package:draggable_scrollbar_sliver/draggable_scrollbar_sliver.dart';
import 'package:flutter/material.dart';
import 'package:doctorpurin/modal/disinfo_model.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisInformation extends StatefulWidget {
  DisInformation() : super();

  final String title = "ค้นหาข้อมูลโรค";
  @override
  _DisInformationState createState() => _DisInformationState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer
          .cancel(); // when the user is continuosly typing, this cancels the timer
    }
    // then we will start a new timer looking for the user to stop
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _DisInformationState extends State<DisInformation> {
  List<DisInfo> _disease;
  List<DisInfo> _filterdisease;
  // DisInfo _selectedDisInfo;
  String id;
  final _debouncer = Debouncer(milliseconds: 500);
  ScrollController _arrowsController = ScrollController();
  @override
  void initState() {
    super.initState();
    _disease = [];
    _filterdisease = [];
    _getDisease();
  }

  _getDisease() {
    Services.getDisease().then((disease) {
      setState(() {
        _disease = disease;
        _filterdisease = disease;
      });

      print("Length: ${disease.length}");
    });
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                "ชื่อโรค",
                style: TextStyle(fontFamily: 'Prompt'),
              ),
            ),
          ],
          rows: _filterdisease
              .map(
                (disease) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        disease.diseasename,
                        style: TextStyle(fontFamily: 'Prompt'),
                      ),
                      onTap: () {
                        print("name " + disease.diseasename);
                        id = disease.diseaseid;
                        print(id);
                        routeTS(ShowDis(), disease);
                      },
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  searchField() {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.all(1.0),
          labelStyle: TextStyle(color: Colors.grey, fontFamily: 'Prompt'),
          labelText: 'ค้นหาโรค :',
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red[200])),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red[200])),
        ),
        onChanged: (string) {
          // We will start filtering when the user types in the textfield.
          // Run the debouncer and start searching
          _debouncer.run(() {
            // Filter the original List and update the Filter list
            setState(() {
              _filterdisease = _disease
                  .where((u) => (u.diseasename
                          .toLowerCase()
                          .contains(string.toLowerCase()) ||
                      u.diseaseid.toLowerCase().contains(string.toLowerCase())))
                  .toList();
            });
          });
        },
      ),
    );
  }

  Future<Null> showGetDis() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String diseaseid = preferences.getString('disease_id');

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getDisWhereId.php?isAdd=true&disease_id=$diseaseid';
    await Dio().get(url).then((value) => {print('value = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('res = $result');
      for (var map in result) {
        DisInfo disInfo = DisInfo.fromJson(map);
        if (diseaseid == disInfo.diseaseid) {
          routeTS(ShowDis(), disInfo);
        }
      }
    } catch (e) {}
  }

  Future<Null> routeTS(Widget myWidgett, DisInfo disInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('disease_id', disInfo.diseaseid);
    preferences.setString('disease_name', disInfo.diseasename);
    preferences.setString('disease_detail', disInfo.diseasedetail);
    preferences.setString('disease_cause', disInfo.diseasecause);
    preferences.setString('disease_risk', disInfo.diseaserisk);
    preferences.setString('disease_chance', disInfo.diseasechance);
    preferences.setString('disease_treatment', disInfo.diseasetreatment);
    preferences.setString('disease_defence', disInfo.diseasedefence);
    preferences.setString('disease_about', disInfo.diseaseabout);
    preferences.setString('expertise_id', disInfo.expertiseid);
    preferences.setString('expertise_name', disInfo.expertisename);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
  }

  Future<Null> refreshList() async {
    Services.getDisease().then((disease) {
      setState(() {
        _disease = disease;
        _filterdisease = disease;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          
            Container(
                child: Text(
              'ข้อมูลโรค',
              style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
            )),
              Image.asset(
              './images/Untitled-1.png',
              height: 40,
            ),
          ],
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: searchField(),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: refreshList,
              backgroundColor: Colors.pink[200],
              child: DraggableScrollbar.arrows(
                alwaysVisibleScrollThumb: true,
                controller: _arrowsController,
                padding: EdgeInsets.only(right: 4.0),
                backgroundColor: Colors.pink[200],
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  controller: _arrowsController,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: _filterdisease.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber[100].withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ]),
                      child: ButtonTheme(
                        minWidth: 500.0,
                        height: 50.0,
                        child: FlatButton(
                          color: Colors.white,
                          onPressed: () {
                            routeTS(ShowDis(), _filterdisease[index]);
                          },
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                          _filterdisease[index].diseasename,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontFamily: 'Prompt',
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                LineIcons.angle_right,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
