import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/main.dart';
import 'package:doctorpurin/modal/ad.dart';
import 'package:doctorpurin/screen/includes/articledis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctorpurin/utility/normal_dialog.dart';

class ShowDis extends StatefulWidget {
  @override
  _ShowDisState createState() => _ShowDisState();
}

class _ShowDisState extends State<ShowDis> {
  int _index = 0;
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
  String ida;
  final List<String> imgList = ['1', '2', '3', '4', '5'];
  List<ArticleDisInfo> articleD = List();
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
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              'โรค $diseasename',
              style: TextStyle(
                  color: Colors.red[900], fontSize: 20.0, fontFamily: 'Prompt'),
            ),
          ),
          CarouselSlider(
            items: [
              showDetail(),
              showCause(),
              showTreatment(),
              showDefence(),
              showData(),
            ],
            options: CarouselOptions(
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                aspectRatio: 2.0,
                height: 400,
                onPageChanged: (index, reason) {
                  setState(() {
                    _index = index;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);
              return Container(
                width: 8.0,
                height: 50.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _index == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
          articleDis(),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent[100],
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        },
        child: Icon(Icons.home),
      ),
    );
  }

  Future<Null> checkid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String diseaseId = preferences.getString('disease_id');
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getArticleDis.php?disease_id=$diseaseId&isAdd=true';
    Response response = await Dio().get(url);
    print('res = $response');

    var result = json.decode(response.data);
    print('resss = $result');
    if (result == null) {
      normalDialog(context, 'ยังไม่มีบทความที่เกี่ยวข้อง');
    } else {
      for (var map in result) {
        ArticleDisInfo articleInfo = ArticleDisInfo.fromJson(map);

        setState(() {
          articleD.add(articleInfo);
          routeTS(NextPage(), articleInfo);
        });
      }
    }
  }

  Future<Null> routeTS(Widget myWidgett, ArticleDisInfo articleInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('articles_id', articleInfo.articlesId);
    preferences.setString('topic', articleInfo.topic);
    preferences.setString('detail', articleInfo.detail);
    preferences.setString('issue_date', articleInfo.issueDate);
    preferences.setString('id', articleInfo.id);
    preferences.setString('doctorname', articleInfo.doctorname);
    preferences.setString('disease_id', articleInfo.diseaseId);
    preferences.setString('disease_name', articleInfo.diseaseName);
    Navigator.pop(context);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
  }

  Widget articleDis() => Container(
        child: Align(
          alignment: Alignment.bottomLeft,
          child: FlatButton(
            onPressed: () {
              checkid();
            },
            child: Text(
              'บทความที่เกี่ยวข้อง',
              style: TextStyle(
                  color: (Colors.lightBlue),
                  fontSize: 18.0,
                  fontFamily: 'Prompt'),
            ),
          ),
        ),
      );

  Widget showTreatment() => SingleChildScrollView(
        child: Card(
          child: Container(
            constraints: BoxConstraints(
              minHeight: 400,
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'การรักษา',
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 18.0,
                        fontFamily: 'Prompt'),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Html(data: ('$diseasetreatment'), style: {
                      "html": Style(
                          fontSize: FontSize(18.0),
                          padding: EdgeInsets.all(2.0),
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Sarabun'),
                    })),
              ],
            ),
          ),
        ),
      );
  Widget showDefence() => SingleChildScrollView(
        child: Card(
            child: Container(
          constraints: BoxConstraints(
            minHeight: 400,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'การป้องกัน',
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 18.0,
                      fontFamily: 'Prompt'),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Html(data: ('$diseasedefence'), style: {
                    "html": Style(
                        fontSize: FontSize(18.0),
                        padding: EdgeInsets.all(2.0),
                        // backgroundColor: Colors.white70,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'Sarabun'),
                  })),
            ],
          ),
        )),
      );
  Widget showCause() => SingleChildScrollView(
        child: Card(
          child: Container(
            constraints: BoxConstraints(
              minHeight: 400,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'สาเหตุ',
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 18.0,
                        fontFamily: 'Prompt'),
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Html(data: ('$diseasecause'), style: {
                      "html": Style(
                          fontSize: FontSize(18.0),
                          padding: EdgeInsets.all(2.0),
                          // backgroundColor: Colors.white70,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Sarabun'),
                    })),
              ],
            ),
          ),
        ),
      );

  Widget showDetail() => SingleChildScrollView(
        child: Card(
          child: Container(
            constraints: BoxConstraints(minHeight: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'รายละเอียด',
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 18.0,
                        fontFamily: 'Prompt'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Html(data: ('$diseasedetail'), style: {
                    "html": Style(
                        fontSize: FontSize(18.0),
                        padding: EdgeInsets.all(2.0),
                        fontWeight: FontWeight.w100,
                        fontFamily: 'Sarabun'),
                  }),
                ),
              ],
            ),
          ),
        ),
      );

  Widget showAbout() => SingleChildScrollView(
        child: Card(
          child: Container(
            constraints: BoxConstraints(
              minHeight: 400,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'หมายเหตุ',
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 18.0,
                        fontFamily: 'Prompt'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Html(data: ('$diseaseabout'), style: {
                    "html": Style(
                        fontSize: FontSize(18.0),
                        padding: EdgeInsets.all(2.0),
                        // backgroundColor: Colors.white70,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'Sarabun'),
                  }),
                ),
              ],
            ),
          ),
        ),
      );

  Widget showData() => SingleChildScrollView(
        child: Card(
          child: Container(
            constraints: BoxConstraints(
              minHeight: 400,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(
                    'ข้อมูลทั่วไป',
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 18.0,
                        fontFamily: 'Prompt'),
                  ),
                ),
                if ('$diseaserisk' != '')
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        'กลุ่มเสี่ยง',
                        style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 18.0,
                            fontFamily: 'Prompt'),
                      ),
                    ),
                  ),

                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Html(data: ('$diseaserisk'), style: {
                      "html": Style(
                          fontSize: FontSize(18.0),
                          padding: EdgeInsets.all(2.0),
                          // backgroundColor: Colors.white70,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Sarabun'),
                    }),
                  ),
                ),

                diseasechance == ""
                    ? Container()
                    : Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            'โอกาสเกิด',
                            style: TextStyle(
                                color: Colors.red[700],
                                fontSize: 18.0,
                                fontFamily: 'Prompt'),
                          ),
                        ),
                      ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Html(data: ('$diseasechance'), style: {
                      "html": Style(
                          fontSize: FontSize(18.0),
                          padding: EdgeInsets.all(2.0),
                          // backgroundColor: Colors.white70,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Sarabun'),
                    }),
                  ),
                ),

                // if ('$expertiseid' != '')
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'ควรพบแพทย์สาขา',
                      style: TextStyle(
                          color: Colors.red[700],
                          fontSize: 18.0,
                          fontFamily: 'Prompt'),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Html(data: ('$expertisename'), style: {
                      "html": Style(
                          fontSize: FontSize(18.0),
                          padding: EdgeInsets.all(2.0),
                          // backgroundColor: Colors.white70,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Sarabun'),
                    }),
                  ),
                ),
                if ('$diseaseabout' != '')
                  ListTile(
                    title: Text(
                      'หมายเหตุ',
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 18.0,
                          fontFamily: 'Prompt'),
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Html(data: ('$diseaseabout'), style: {
                    "html": Style(
                        fontSize: FontSize(18.0),
                        padding: EdgeInsets.all(2.0),
                        // backgroundColor: Colors.white70,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'Sarabun'),
                  }),
                ),
              ],
            ),
          ),
        ),
      );
}
