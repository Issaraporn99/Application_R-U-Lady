import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/screen/disease/service.dart';
import 'package:doctorpurin/screen/disease/showdis.dart';
import 'package:flutter/material.dart';
import 'package:doctorpurin/modal/disinfo_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _getDisease();
    });
    _refreshController.refreshCompleted();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ข้อมูลโรค',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropMaterialHeader(
          backgroundColor: Colors.pinkAccent[100],
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
     
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: searchField(),
              ),
              Expanded(
                child: _dataBody(),
              ),
            ],
          
        ),
      ),
    );
  }
}
