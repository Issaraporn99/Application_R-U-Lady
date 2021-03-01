import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:doctorpurin/screen/check/showResult.dart';
import 'package:doctorpurin/screen/check/showResult2.dart';
import 'package:doctorpurin/screen/check/showResult3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSym extends StatefulWidget {
  @override
  _ShowSymState createState() => _ShowSymState();
}

class _ShowSymState extends State<ShowSym> {
  String symptomId;
  String symptomName = "...";
  String groupId;
  String diseaseId;
  String id;
  String dis;
  String status;
  String yn;
  String grgr = "";
  int yyy = 0;
  int yyy2 = 0;
  String yyyyyy = "";
  int limit = 0;
  var diss = new List();
  List<GroupSym> strArr = List();
  var symm = new List();
  var ynn = new List();
  var statuss = new List();
  var symName = new List();
  var ggg = new List();

  var dis2 = new List();
  var sym2 = new List();
  var status2 = new List();
  var yn2 = new List();
  int d = 2;
  String ym = "";
  var symmYN = new List();
  String symmYNId;
  var symYNname = new List();
  String symYname = "";
  @override
  void initState() {
    super.initState();
    findId();
  }

  Future<Null> findId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String groupId = preferences.getString('group_id');

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym.php?group_id=$groupId&isAdd=true';
    await Dio().get(url).then((value) => {print('findId = $value')});

    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print("result=$result");
    setState(() {
      for (var x in result) {
        symm.add(x['symptom_id']);
      }
      for (var x in symm) {
        symptomId = x;
      }
      for (var x in result) {
        symName.add(x['symptom_name']);
      }
      for (var x in symName) {
        symptomName = x;
      }
      print(" symptomName=$symptomName");
    });
  }

  Future<Null> showSymYn() async {
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/showSymYn.php?&isAdd=true';
    await Dio().get(url).then((value) => {print('findId = $value')});
    Response response = await Dio().get(url);
    if (response.toString() == 'null') {
      print(" symYname=$symYname");
    } else {
      var result = json.decode(response.data);
      setState(() {
        for (var x in result) {
          symmYN.add(x['symptom_id']);
        }
        for (var x in symmYN) {
          symmYNId = x;
        }
        for (var x in result) {
          symYNname.add(x['symptom_name']);
        }
        for (var x in symYNname) {
          symYname = symYname + x;
        }
        print(" symYname=$symYname");
      });
    }
  }

  Future<Null> count() async {
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/countSym.php?isAdd=true';
    Response response = await Dio().get(url);
    print('res=$response');
    if (response.toString() == 'null') {
      setState(() {
        d = 0;
        print("d null=$d");
      });
    } else {
      var result = json.decode(response.data);
      var dd = new List();
      setState(() {
        for (var x in result) {
          dd.add(x);
        }
        print(dd);

        d = dd.length;
        print("d=$d");
      });
    }
  }

  Future<Null> idArray() async {
    limit = 0;
    await count();
    if (d <= 1) {
      getDis();
    } else {
      String text = "";
      int cnum = diss.length;
      int i = 1;
      for (var x in diss) {
        if (i == cnum) {
          text = text + x;
        } else {
          text = text + x + ",";
        }
        i++;
      }
      print("ล่าสุด=$text");

      String text2 = "";
      int cnum2 = ynn.length;
      int i2 = 1;
      for (var x in ynn) {
        if (i2 == cnum2) {
          text2 = x;
        }
        i2++;
      }
      print("ล่าสุด=$text2");
      print("d=$d");
      if (text2 == "a" && d == 1) {
        getDis();
      } else if (cnum == 1 && text2 == "y") {
        getDis();
      } else {
        setState(() {
          diss = [];
          symm = [];
          symName = [];
          sym2 = [];
          ynn = [];
        });

        String url =
            'http://student.crru.ac.th/601463046/apidoctor/apiSym2.php?symptom_id=$symptomId&isAdd=true';
        await Dio().get(url).then((value) => {print('idArray = $value')});
        Response response = await Dio().get(url);
        var result = json.decode(response.data);
        print("$result");
        setState(() {
          for (var x in result) {
            diss.add(x['disease_id']);
          }
          for (var x in result) {
            symm.add(x['symptom_id']);
          }
          for (var x in result) {
            statuss.add(x['status']);
          }
          for (var x in result) {
            ynn.add(x['yn']);
          }
          for (var x in result) {
            ggg.add(x['group_id']);
          }
          for (var x in ggg) {
            grgr = grgr + x;
          }
          print("$grgr");
        });

        updateYN();
      }
    }
  }

  Future<Null> updateYN() async {
    String tt1 = "";
    int cnum = diss.length;
    int i = 1;
    int n = 0;
    for (var x in diss) {
      if (i == cnum) {
        tt1 = tt1 + "diss[" + '$n' + "]=" + x;
      } else {
        tt1 = tt1 + "diss[" + '$n' + "]=" + x + "&";
      }
      n++;
      i++;
    }

    String tt2 = "";
    int cnum2 = symm.length;
    int i2 = 1;
    int n2 = 0;
    for (var x2 in symm) {
      if (i2 == cnum2) {
        tt2 = tt2 + "symm[" + '$n2' + "]=" + x2;
      } else {
        tt2 = tt2 + "symm[" + '$n2' + "]=" + x2 + "&";
      }
      n2++;
      i2++;
    }

    String tt3 = "";
    int cnum3 = statuss.length;
    int i3 = 1;
    int n3 = 0;
    for (var x3 in statuss) {
      if (i3 == cnum3) {
        tt3 = tt3 + "statuss[" + '$n3' + "]=" + x3;
      } else {
        tt3 = tt3 + "statuss[" + '$n3' + "]=" + x3 + "&";
      }
      n3++;
      i3++;
    }

    String tt4 = "";
    int cnum4 = ynn.length;
    int i4 = 1;
    int n4 = 0;
    for (var x4 in ynn) {
      if (i4 == cnum4) {
        tt4 = tt4 + "ynn[" + '$n4' + "]=y";
      } else {
        tt4 = tt4 + "ynn[" + '$n4' + "]=y&";
      }
      n4++;
      i4++;
    }

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/updateYN.php?&$tt1&$tt2&$tt3&$tt4&isAdd=true';
    await Dio().get(url).then((value) => {print('updateYN = $value')});

    delsym();
  }

  Future<Null> delsym() async {
    String del = "";
    int cnum = diss.length;
    int i = 1;
    for (var x in diss) {
      if (i == cnum) {
        del = del + x;
      } else {
        del = del + x + ",";
      }
      i++;
    }

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/delsym.php?&del=$del&isAdd=true';
    await Dio().get(url).then((value) => {print('del = $value')});
    Response response = await Dio().get(url);
    // var result = json.decode(response.data);
    coutsymmmm();
  }

  Future<Null> coutsymmmm() async {
    await count();
    print("d=$d");
    print("ym=$ym");
    if (d == 0) {
      await countyn();
      if (ym == "y") {
        getDis();
      } else {
        getDis2();
      }
    } else {
      String text = "";
      int cnum = diss.length;
      int i = 1;
      for (var x in diss) {
        if (i == cnum) {
          text = text + x;
        } else {
          text = text + x + ",";
        }
        i++;
      }
      print("โรคที่ถามไปล่าสุด=$text");

      String text2 = "";
      int cnum2 = ynn.length;
      int i2 = 1;
      for (var x in ynn) {
        if (i2 == cnum2) {
          text2 = x;
        }
        i2++;
      }
      print("text2ล่าสุด=$text2");
      String text3 = "";
      int cnum3 = symm.length;
      int i3 = 1;
      for (var x in symm) {
        if (i3 == cnum3) {
          text3 = x;
        }
        i3++;
      }
      print("D=$d");
      String grgr = "";
      int cnum4 = ggg.length;
      int i4 = 1;
      for (var x in ggg) {
        if (i4 == cnum4) {
          grgr = x;
        }
        i4++;
      }
      print("grgr=$grgr");
      if (cnum == 1 && text2 == "y") {
        getDis();
      } else {
        setState(() {
          symptomId = '';
          symptomName = '';
        });

        String url =
            'http://student.crru.ac.th/601463046/apidoctor/apiSym33.php?&text=$text&group_id=$grgr&isAdd=true';
        await Dio().get(url).then((value) => {print('coutsym33 = $value')});
        Response response = await Dio().get(url);
        if (response.toString() == 'null') {
          coutsym();
        } else {
          var result = json.decode(response.data);
          setState(() {
            for (var x in result) {
              symName.add(x['symptom_name']);
            }
            String sn = "";
            for (var s in symName) {
              sn = sn + s;
            }
            for (var x in result) {
              dis2.add(x['disease_id']);
            }
            for (var x in result) {
              sym2.add(x['symptom_id']);
            }
            String snn = "";
            for (var s in sym2) {
              snn = snn + s;
            }
            print(snn);
            for (var x in result) {
              status2.add(x['status']);
            }
            for (var x in result) {
              ynn.add(x['yn']);
            }
            print(sn);
            symptomName = sn;
            symptomId = snn;
          });
        }
      }
    }
  }

  Future<Null> coutsym() async {
    await count();

    print("d=$d");
    print("ym=$ym");
    if (d == 0) {
      await countyn();
      if (ym == "y") {
        getDis();
      } else {
        getDis2();
      }
    } else {
      String text = "";
      int cnum = diss.length;
      int i = 1;
      for (var x in diss) {
        if (i == cnum) {
          text = text + x;
        } else {
          text = text + x + ",";
        }
        i++;
      }
      print("โรคที่ถามไปล่าสุด=$text");

      String text2 = "";
      int cnum2 = ynn.length;
      int i2 = 1;
      for (var x in ynn) {
        if (i2 == cnum2) {
          text2 = x;
        }
        i2++;
      }
      print("text2ล่าสุด=$text2");
      String text3 = "";
      int cnum3 = symm.length;
      int i3 = 1;
      for (var x in symm) {
        if (i3 == cnum3) {
          text3 = x;
        }
        i3++;
      }
      print("D=$d");

      if (cnum == 1 && text2 == "y") {
        getDis();
      } else {
        setState(() {
          symptomId = '';
          symptomName = '';
        });

        String url =
            'http://student.crru.ac.th/601463046/apidoctor/apiSym3.php?&text=$text&isAdd=true';
        await Dio().get(url).then((value) => {print('coutsym = $value')});
        Response response = await Dio().get(url);
        var result = json.decode(response.data);
        setState(() {
          for (var x in result) {
            symName.add(x['symptom_name']);
          }
          String sn = "";
          for (var s in symName) {
            sn = sn + s;
          }
          for (var x in result) {
            dis2.add(x['disease_id']);
          }
          for (var x in result) {
            sym2.add(x['symptom_id']);
          }
          String snn = "";
          for (var s in sym2) {
            snn = snn + s;
          }
          print(snn);
          for (var x in result) {
            status2.add(x['status']);
          }
          for (var x in result) {
            ynn.add(x['yn']);
          }
          print(sn);
          symptomName = sn;
          symptomId = snn;
        });
      }
    }
  }

  Future<Null> getDis() async {
    Navigator.pop(context);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => ShowResult());
    Navigator.push(context, route);
  }

  Future<Null> getDis2() async {
    Navigator.pop(context);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => ShowResult2());
    Navigator.push(context, route);
  }

  Future<Null> getDis3() async {
    Navigator.pop(context);
    MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => ShowResult3());
    Navigator.push(context, route);
  }

  Future<Null> countyn() async {
    setState(() {
      ynn = [];
    });
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getYN.php?isAdd=true';
    await Dio().get(url).then((value) => {print('countyn = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    setState(() {
      for (var x in result) {
        ynn.add(x['yn']);
      }
      for (var s in ynn) {
        ym = s;
      }
      print(ym);
    });
  }

  Future<Null> updateYN2() async {
    String tt1 = "";
    int cnum = diss.length;
    int i = 1;
    int n = 0;
    for (var x in diss) {
      if (i == cnum) {
        tt1 = tt1 + "diss[" + '$n' + "]=" + x;
      } else {
        tt1 = tt1 + "diss[" + '$n' + "]=" + x + "&";
      }
      n++;
      i++;
    }

    String tt2 = "";
    int cnum2 = symm.length;
    int i2 = 1;
    int n2 = 0;
    for (var x2 in symm) {
      if (i2 == cnum2) {
        tt2 = tt2 + "symm[" + '$n2' + "]=" + x2;
      } else {
        tt2 = tt2 + "symm[" + '$n2' + "]=" + x2 + "&";
      }
      n2++;
      i2++;
    }

    String tt3 = "";
    int cnum3 = statuss.length;
    int i3 = 1;
    int n3 = 0;
    for (var x3 in statuss) {
      if (i3 == cnum3) {
        tt3 = tt3 + "statuss[" + '$n3' + "]=" + x3;
      } else {
        tt3 = tt3 + "statuss[" + '$n3' + "]=" + x3 + "&";
      }
      n3++;
      i3++;
    }

    String tt4 = "";
    int cnum4 = ynn.length;
    int i4 = 1;
    int n4 = 0;
    for (var x4 in ynn) {
      if (i4 == cnum4) {
        tt4 = tt4 + "ynn[" + '$n4' + "]=y";
      } else {
        tt4 = tt4 + "ynn[" + '$n4' + "]=y&";
      }
      n4++;
      i4++;
    }

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/updateYN.php?&$tt1&$tt2&$tt3&$tt4&isAdd=true';
    await Dio().get(url).then((value) => {print('updateYN2 = $value')});

    getDis();
  }

///////// ตอบไม่ //////////////////
  Future<Null> countDis() async {
    yyy = 0;
    var yy = [];
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/countDis.php?isAdd=true';
    Response response = await Dio().get(url);
    var result = json.decode(response.data);

    setState(() {
      for (var x in result) {
        yy.add(x['disease_id']);
      }
      yyy = yy.length;
      print(yyy);
    });
    countDis2();
  }

  Future<Null> countDis2() async {
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/cyn.php?isAdd=true';
    Response response = await Dio().get(url);
    print('res=$response');
    if (response.toString() == 'null') {
      setState(() {
        yyy2 = 1;
        print("d null=$d");
      });
    } else {
      setState(() {
        var yy2 = [];
        var result = json.decode(response.data);
        for (var x in result) {
          yy2.add(x['yn']);
        }
        yyy2 = yy2.length;
        print(yyy2);
      });
    }
  }

  Future<Null> idArray2() async {
    limit = 0;
    if (d > 1) {
      count();
    }
    String text = "";
    int cnum = diss.length;
    int i = 1;
    for (var x in diss) {
      if (i == cnum) {
        text = text + x;
      } else {
        text = text + x + ",";
      }
      i++;
    }
    print("ล่าสุด=$text");

    String text2 = "";
    int cnum2 = ynn.length;
    int i2 = 1;
    for (var x in ynn) {
      if (i2 == cnum2) {
        text2 = x;
      }
      i2++;
    }
    print("ล่าสุด=$text2");
    print("Dd=$d");

    if (d == 0) {
      getDis2();
    } else {
      setState(() {
        diss = [];
        symm = [];
        symName = [];
        sym2 = [];
        ynn = [];
      });

      String url =
          'http://student.crru.ac.th/601463046/apidoctor/apiSym2.php?symptom_id=$symptomId&isAdd=true';
      await Dio().get(url).then((value) => {print('idArray2 = $value')});
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      print("$result");
      setState(() {
        for (var x in result) {
          diss.add(x['disease_id']);
        }
        print(diss);
        for (var x in result) {
          symm.add(x['symptom_id']);
        }
        for (var x in result) {
          statuss.add(x['status']);
        }
        for (var x in result) {
          ynn.add(x['yn']);
        }
        for (var x in result) {
          ggg.add(x['group_id']);
        }
        for (var x in ggg) {
          grgr = grgr + x;
        }
        print("$grgr");
      });
      getno();
    }
  }

  Future<Null> delsym2() async {
    if (d > 1) {
      count();
    }
    String del = "";
    int cnum = diss.length;
    int i = 1;
    for (var x in diss) {
      if (i == cnum) {
        del = del + x;
      } else {
        del = del + x + ",";
      }
      i++;
    }

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/delsym2.php?&del=$del&isAdd=true';
    await Dio().get(url).then((value) => {print('del2 = $value')});
    Response response = await Dio().get(url);
    // var result = json.decode(response.data);
    coutsym22();
  }

  Future<Null> coutsym22() async {
    await count();
    if (d == 0) {
      getDis2();
    } else {
      String text = "";
      int cnum = diss.length;
      int i = 1;
      for (var x in diss) {
        if (i == cnum) {
          text = text + x;
        } else {
          text = text + x + ",";
        }
        i++;
      }
      print("ล่าสุด=$text");

      String text2 = "";
      int cnum2 = ynn.length;
      int i2 = 1;
      for (var x in ynn) {
        if (i2 == cnum2) {
          text2 = x;
        }
        i2++;
      }
      print("ล่าสุด=$text2");
      String grgr = "";
      int cnum3 = ggg.length;
      int i3 = 1;
      for (var x in ggg) {
        if (i3 == cnum3) {
          grgr = x;
        }
        i3++;
      }
      print("ล่าสุด=$grgr");

      if (d == 0) {
        getDis2();
      } else {
        setState(() {
          symptomId = '';
          symptomName = '';
        });

        String url =
            'http://student.crru.ac.th/601463046/apidoctor/countgg.php?&text=$text&group_id=$grgr&isAdd=true';
        await Dio().get(url).then((value) => {print('coutsym2 = $value')});
        Response response = await Dio().get(url);
        if (response.toString() == 'null') {
          coutsym2();
        } else {
          var result = json.decode(response.data);
          print("resultidarray2$result");
          setState(() {
            for (var x in result) {
              symName.add(x['symptom_name']);
            }
            String sn = "";
            for (var s in symName) {
              sn = sn + s;
            }
            for (var x in result) {
              dis2.add(x['disease_id']);
            }
            for (var x in result) {
              sym2.add(x['symptom_id']);
            }
            String snn = "";
            for (var s in sym2) {
              snn = snn + s;
            }
            print(snn);
            for (var x in result) {
              status2.add(x['status']);
            }
            for (var x in result) {
              ynn.add(x['yn']);
            }
            print(sn);
            symptomName = sn;
            symptomId = snn;
          });
        }
      }
    }
  }

  Future<Null> getno() async {
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/getno.php?isAdd=true';
    await Dio().get(url).then((value) => {print('getno = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    var dis2 = new List();

    setState(() {
      for (var x in result) {
        dis2.add(x['disease_id']);
      }
      print(dis2);

      int a = dis2.length;
      print(a);

      if (a > 1) {
        delsym2();
      } else {
        getDis2();
      }
    });
  }

  Future<Null> coutsym2() async {
    await count();
    if (d == 0) {
      getDis2();
    } else {
      String text = "";
      int cnum = diss.length;
      int i = 1;
      for (var x in diss) {
        if (i == cnum) {
          text = text + x;
        } else {
          text = text + x + ",";
        }
        i++;
      }
      print("ล่าสุด=$text");

      String text2 = "";
      int cnum2 = ynn.length;
      int i2 = 1;
      for (var x in ynn) {
        if (i2 == cnum2) {
          text2 = x;
        }
        i2++;
      }
      print("ล่าสุด=$text2");

      if (d == 0) {
        getDis2();
      } else {
        setState(() {
          symptomId = '';
          symptomName = '';
        });

        String url =
            'http://student.crru.ac.th/601463046/apidoctor/idarray2.php?&text=$text&isAdd=true';
        await Dio().get(url).then((value) => {print('coutsym2 = $value')});
        Response response = await Dio().get(url);
        var result = json.decode(response.data);
        print("resultidarray2$result");
        setState(() {
          for (var x in result) {
            symName.add(x['symptom_name']);
          }
          String sn = "";
          for (var s in symName) {
            sn = sn + s;
          }
          for (var x in result) {
            dis2.add(x['disease_id']);
          }
          for (var x in result) {
            sym2.add(x['symptom_id']);
          }
          String snn = "";
          for (var s in sym2) {
            snn = snn + s;
          }
          print(snn);
          for (var x in result) {
            status2.add(x['status']);
          }
          for (var x in result) {
            ynn.add(x['yn']);
          }
          print(sn);
          symptomName = sn;
          symptomId = snn;
        });
      }
    }
  }

  Future<Null> apiSym32() async {
    await count();
    setState(() {
      symName = [];
      sym2 = [];
      limit = limit + 1;
    });

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym32.php?&text=$limit&isAdd=true';

    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    if (response.toString() == 'null') {
      getDis2();
    } else {
      setState(() {
        for (var x in result) {
          symName.add(x['symptom_name']);
        }
        String sn = "";
        for (var s in symName) {
          sn = sn + s;
        }
        for (var x in result) {
          dis2.add(x['disease_id']);
        }
        for (var x in result) {
          sym2.add(x['symptom_id']);
        }
        String snn = "";
        for (var s in sym2) {
          snn = snn + s;
        }
        print(snn);
        for (var x in result) {
          status2.add(x['status']);
        }
        for (var x in result) {
          ynn.add(x['yn']);
        }
        print(sn);
        symptomName = sn;
        symptomId = snn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfcdada),
      appBar: AppBar(
        title: Text(
          'คุณมีอาการอะไรบ้าง?',
          style: TextStyle(color: Colors.white, fontFamily: 'Prompt'),
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              sym(),
            ],
          ),
        ),
      ),
    );
  }

  Widget sym() => Container(
          child: SizedBox(
        width: 330,
        child: Card(
          color: Colors.white,
          child: Container(
            constraints:
                BoxConstraints(minHeight: 300, minWidth: double.infinity),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Text(('$symptomName' ?? '...'),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontFamily: 'Prompt',
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 100, bottom: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: RaisedButton(
                            onPressed: () {
                              idArray();
                            },
                            color: Color(0xFF00af91),
                            padding: EdgeInsets.all(5),
                            child: Text('ใช่',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontFamily: 'Prompt',
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100, bottom: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: RaisedButton(
                            onPressed: () {
                              idArray2();
                            },
                            color: Color(0xFFff7171),
                            padding: EdgeInsets.all(5),
                            child: Text('ไม่ใช่',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontFamily: 'Prompt',
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 100, bottom: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: RaisedButton(
                            onPressed: () {
                              apiSym32();
                            },
                            color: Color(0xFFffc75f),
                            padding: EdgeInsets.all(5),
                            child: Text('ไม่แน่ใจ',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontFamily: 'Prompt',
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ));
}
