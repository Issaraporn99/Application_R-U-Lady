import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/screen/disease/service.dart';
import 'package:doctorpurin/screen/disease/showdis.dart';
import 'package:flutter/material.dart';
import 'package:doctorpurin/modal/disinfo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DisInformation extends StatefulWidget {
  DisInformation() : super();

  final String title = "ค้นหาข้อมูลโรค";
  @override
  _DisInformationState createState() => _DisInformationState();
}

class _DisInformationState extends State<DisInformation> {
  List<DisInfo> _disease;
  String id;
  @override
  void initState() {
    super.initState();
    _disease = [];
    _getDisease();
  }

  _getDisease() {
    Services.getDisease().then((disease) {
      setState(() {
        _disease = disease;
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
                label: Text("ค้นหาโรค"),
                numeric: false,
                tooltip: "This is the employee id"),
          ],
          rows: _disease
              .map(
                (disease) => DataRow(
                  cells: [
                    DataCell(
                      Text(disease.diseasename,
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




Future<Null> showGetDis() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String diseaseid = preferences.getString('disease_id');

    String url =
        'http://192.168.1.108/apidoctor/getDisWhereId.php?isAdd=true&disease_id=$diseaseid';
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
          title: Text('ค้นหาโรคทั้งหมด'),
        ),
        body: Container(
           child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
             child: _dataBody(),
        ))));
  }
}

// Future<Null> readDis() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   String disease_id = preferences.getString('disease_id');

//   String url =
//       'http://192.168.43.187/issaafood/disInfo.php?isAdd=true&disease_id=$disease_id';
//   // await Dio().get(url).then((value) => {print('value = $value')});
//   Response response = await Dio().get(url);
//   print('dis = $response');
//   var result = json.decode(response.data);
//   dis = result;
//   // print(dis);
// }
