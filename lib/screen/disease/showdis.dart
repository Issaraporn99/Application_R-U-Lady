import 'package:doctorpurin/modal/ad.dart';
import 'package:doctorpurin/screen/includes/articledis.dart';
import 'package:doctorpurin/screen/women_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ShowDis extends StatefulWidget {
  @override
  _ShowDisState createState() => _ShowDisState();
}

class _ShowDisState extends State<ShowDis> {
  var _textController = new TextEditingController();
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
  String ida;
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
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
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
              ],
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  height: 400),
              carouselController: _controller,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: FlatButton(
                      onPressed: () => _controller.previousPage(),
                      child: Image.asset(
                        'images/pre.png',
                        width: 30,
                      ),
                    ),
                  ),
                  articleDis(),
                  Align(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                      onPressed: () => _controller.nextPage(),
                      child: Image.asset(
                        'images/next.png',
                        width: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WomenHome()));
                },
                child: Image.asset(
                  'images/btnh.png',
                  width: 80,
                ),
              ),
            ),
          ]),
        ));
  }

  // Future<Null> showGetArticle() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String diseaseId = preferences.getString('disease_id');

  //   String url =
  //       'http://10.7.0.80/apidoctor/getArticleDis.php?isAdd=true&disease_id=$diseaseId';
  //   await Dio().get(url).then((value) => {print('value = $value')});
  //   try {
  //     Response response = await Dio().get(url);
  //     print('res = $response');

  //     var result = json.decode(response.data);
  //     print('res = $result');
  //     for (var map in result) {
  //       ArticleDisInfo articleInfo = ArticleDisInfo.fromJson(map);
  //       if (diseaseId == articleInfo.diseaseId) {
  //         routeTS(ArticleDis(diseaseId: diseaseId,), articleInfo);
  //       }
  //     }
  //   } catch (e) {}
  // }

  Future<Null> routeTS(Widget myWidgett, ArticleDisInfo articleInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('articles_id', articleInfo.articlesId);
    preferences.setString('topic', articleInfo.topic);
    preferences.setString('detail', articleInfo.detail);
    preferences.setString('issue_date', articleInfo.issueDate);
    preferences.setString('id', articleInfo.id);
    preferences.setString('disease_id', articleInfo.diseaseId);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
  }

  Widget articleDis() => Container(
        child: Align(
          alignment: Alignment.topLeft,
          child: FlatButton(
            onPressed: () {
              var route = new MaterialPageRoute(
                builder: (BuildContext context) => NextPage(value: diseaseid),
              );
              Navigator.of(context).push(route);
            },
            child: Text(
              'บทความที่เกี่ยวข้อง',
              style: TextStyle(
                color: (Colors.lightBlue),
                fontSize: 14.0,
              ),
            ),
          ),
        ),
      );

  Widget showTreatment() => SingleChildScrollView(
        child: Card(
          child: Container(
            child: Column(
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
                    padding: const EdgeInsets.only(left: 20, right: 35),
                    child: Html(
                      data: ('$diseasetreatment'),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  Widget showDefence() => SingleChildScrollView(
        child: Card(
            child: Container(
          // height: 400,
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
                  padding: const EdgeInsets.only(left: 20, right: 35),
                  child: Html(
                    data: ('$diseasedefence'),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '4',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      );
  Widget showCause() => SingleChildScrollView(
        child: Card(
          child: Container(
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 40, bottom: 20),
                    child: Html(
                      data: ('$diseasecause'),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget showDetail() => SingleChildScrollView(
        child: Card(
          child: Container(
            // height: 420,
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
                  padding:
                      const EdgeInsets.only(left: 20, right: 37, bottom: 20),
                  child: Html(
                    data: ('$diseasedetail'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget showAbout() => SingleChildScrollView(
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
                padding: const EdgeInsets.only(left: 20, right: 40, bottom: 20),
                child: Html(
                  data: ('$diseaseabout'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget showData() => SingleChildScrollView(
        child: Card(
          child: Container(
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
                      padding: const EdgeInsets.only(left: 20, right: 40),
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
                    padding: const EdgeInsets.only(left: 20, right: 40),
                    child: Html(data: ('$diseaserisk')),
                  ),
                ),
                if ('$diseasechance' != '')
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 40),
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
                    padding: const EdgeInsets.only(left: 20, right: 40),
                    child: Html(data: ('$diseasechance')),
                  ),
                ),
                // if ('$expertiseid' != '')
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 40),
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
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Html(data: ('$expertisename')),
                  ),
                ),
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
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: Html(
                    data: ('$diseaseabout'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        '5',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

