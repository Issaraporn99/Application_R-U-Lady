import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/ad.dart';
import 'package:doctorpurin/screen/includes/showad.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => new _NextPageState();
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

class _NextPageState extends State<NextPage> {
  // List<ArticleDisInfo> _article;
  String diseaseId;
  String ida;
  String topic;
  List<ArticleDisInfo> articleD = List();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    // _article = [];
    // _getArticle2();
    Intl.defaultLocale = "th";
    initializeDateFormatting();
    findId();
  }

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      diseaseId = preferences.getString('disease_id');
      checkid();
    });
  }

  Future<Null> checkid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    diseaseId = preferences.getString('disease_id');
    String url =
        'http://192.168.1.108/apidoctor/getArticleDis.php?disease_id=$diseaseId&isAdd=true';
    Response response = await Dio().get(url);
    print('resrr = $response');

    var result = json.decode(response.data);
    print('res = $result');
    for (var map in result) {
      ArticleDisInfo articleInfo = ArticleDisInfo.fromJson(map);
      setState(() {
        articleD.add(articleInfo);
      });
    }
  }
Future<Null> showGetArticle() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String articlesId = preferences.getString('articles_id');

    String url =
        'http://192.168.1.108/apidoctor/getArticleWhereId.php?isAdd=true&articles_id=$articlesId';
    await Dio().get(url).then((value) => {print('value = $value')});
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('resss = $result');
      for (var map in result) {
        ArticleDisInfo articleInfo = ArticleDisInfo.fromJson(map);
        if (articlesId == articleInfo.articlesId) {
          routeTS(ShowAD(), articleInfo);
        }
      }
    } catch (e) {}
  }
    Future<Null> routeTS(Widget myWidgett, ArticleDisInfo articleInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('articles_id', articleInfo.articlesId);
    preferences.setString('topic', articleInfo.topic);
    preferences.setString('detail', articleInfo.detail);
    preferences.setString('issue_date', articleInfo.issueDate);
    preferences.setString('id', articleInfo.id);
    preferences.setString('doctorname', articleInfo.doctorname);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => myWidgett);
    Navigator.push(context, route);
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
                "บทความ",
                style: TextStyle(fontFamily: 'Prompt'),
              ),
            ),
          ],
          rows: articleD
              .map(
                (article) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        article.topic,
                        style: TextStyle(fontFamily: 'Prompt'),
                      ),
                      onTap: () {
                        print("name " + article.topic);
                        ida = article.articlesId;
                        print(ida);
                        routeTS(ShowAD(), article);
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

//   @override
//   Widget build(BuildContext context) {
//      return articleD.length == 0
//         ? Center(
//             child: CircularProgressIndicator(),
//           )
//         // body: new Text("${widget.value}"),
//         : ListView.builder(
//             itemBuilder: (ctx, index) {
//               return GestureDetector(
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.only(top: 10.0, left: 10, right: 10),
//                     child: Card(
//                       elevation: 1.5,
//                       color: Color(0xFFF7F7F9),
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 15),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '${articleD[index].diseaseId}',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 Text(
//                                   '${articleD[index].topic}',
//                                   // DateFormat.yMMMMd()
//                                   //     .format(myModels[index].detaMissing),
//                                   style: TextStyle(color: Colors.grey[700]),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                   ),
//                 ),
//               );
//             },
//             itemCount: articleD.length,
//           );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ค้นหาบทความ'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
    );
  }
}
