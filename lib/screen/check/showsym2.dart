import 'dart:convert';
//หน้า show ของไม่ทราบ
import 'package:dio/dio.dart';
import 'package:doctorpurin/modal/group_modal.dart';
import 'package:doctorpurin/screen/check/showResult.dart';
import 'package:doctorpurin/screen/check/showResult2.dart';
import 'package:doctorpurin/screen/check/showResult3.dart';
import 'package:doctorpurin/utility/my_style.dart';
import 'package:flutter/material.dart';

class ShowSym2 extends StatefulWidget {
  @override
  _ShowSym2State createState() => _ShowSym2State();
}

class _ShowSym2State extends State<ShowSym2> {
  String symptomId;
  String before;
  String img = "";
  String iii;
  var imgs = new List();
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
  var bf = new List();

  var dis2 = new List();
  var sym2 = new List();
  var status2 = new List();
  var yn2 = new List();
  int d = 2;
  int cDis = 0;
  int cDis2 = 0;
  String cDis3 = "";
  String ym = "";
  var symmYN = new List();
  String symmYNId;
  var symYNname = new List();
  String symYname = "";
  var did = new List();
  String did2 = "";
  int no = 0;
  String a = "";
  var stt = new List();
  var namebf = new List();
  String namebef = "";
  String idbf = "";
  var ynnnnnn = List();
  String ynnnn = "";
  var disNoBf = List();
  var grNoBf = List();
  @override
  void initState() {
    super.initState();
    findId();
  }

  Future<Null> findId() async {
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/symNoName.php?&isAdd=true';
    await Dio().get(url).then((value) => {print('findIdShowSym2 = $value')});
    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print("result=$result");
    setState(() {
      for (var x in result) {
        ynnnnnn.add(x['yn']);
      }
      for (var x in ynnnnnn) {
        ynnnn = x;
      }
      if (ynnnn == "y" || ynnnn == "u") {
        idBF(); //  ตรงนี้ต้องแก้
      }
      for (var x in result) {
        symm.add(x['symptom_id']);
      }
      for (var x in symm) {
        symptomId = x;
      }
      for (var x in result) {
        symName.add(x['symptom_name']);
      }

      print(" symptomName=$symptomName");

      for (var x in result) {
        imgs.add(x['img']);
      }
      for (var x in imgs) {
        iii = x;
      }
      for (var x in result) {
        bf.add(x['before_id']);
      }
      for (var x in bf) {
        before = x;
      }
      print(" before=$before");
      if (before == "0") {
        for (var x in symName) {
          symptomName = x; //findId()
        }
      } else {
        symptomName = "...";
        findbf();
      }
    });
  }

  Future<Null> findbf() async {
    a = "";
    namebf = [];
    print("before=$before");
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/findBf.php?before_id=$before&isAdd=true';
    await Dio().get(url).then((value) => {print('findbf = $value')});

    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print("result=$result");
    if (result.toString() == "null") {
      print("null");
    } else {
      setState(() {
        for (var x in result) {
          stt.add(x['status']);
        }
        for (var x in stt) {
          a = x;
        }
        print("a=$a");
        if (a == "2") {
          setState(() {
            symptomName = "...";
          });
          noBf();
        } else {
          for (var x in result) {
            namebf.add(x['before_ques']);
          }
          for (var x in namebf) {
            namebef = x;
          }
          for (var x in symName) {
            symptomName = x; //findbf()
          }
        }
      });
    }
  }

  Future<Null> noBf() async {
    disNoBf = [];
    print("before=$before");
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/noBf.php?before_id=$before&isAdd=true';
    await Dio().get(url).then((value) => {print('findbf = $value')});

    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print("result=$result");
    if (result.toString() == "null") {
      print("resultnull");
    } else {
      setState(() {
        for (var x in result) {
          disNoBf.add(x['disease_id']);
        }
        for (var x in result) {
          grNoBf.add(x['group_id']);
        }

        String text = "";
        int cnum = disNoBf.length;
        int i = 1;
        for (var x in disNoBf) {
          if (i == cnum) {
            text = text + x;
          } else {
            text = text + x + ",";
          }
          i++;
        }
      });
      if (disNoBf.length <= 1) {
        await getCountDis();
      } else {
        nodel();
      }
    }
  }

  Future<Null> nodel() async {
    if (d > 1) {
      count();
    }
    String del = "";
    int cnum = disNoBf.length;
    int i = 1;
    for (var x in disNoBf) {
      if (i == cnum) {
        del = del + x;
      } else {
        del = del + x + ",";
      }
      i++;
    }
    print("del=$del");

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/delsym2.php?&del=$del&isAdd=true';
    await Dio().get(url).then((value) => {print('nodel = $value')});
    Response response = await Dio().get(url);
    // var result = json.decode(response.data);

    coutsym22No();
  }

  Future<Null> coutsym22No() async {
    await count();
    if (d == 0) {
      getDis2();
    } else {
      String text = "";
      int cnum = disNoBf.length;
      int i = 1;
      for (var x in disNoBf) {
        if (i == cnum) {
          text = text + x;
        } else {
          text = text + x + ",";
        }
        i++;
      }
      print("ล่าสุด=$text");

      String grgr = "";
      int cnum3 = grNoBf.length;
      int i3 = 1;
      for (var x in grNoBf) {
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
          iii = '';
          img = '';
        });

        String url =
            'http://student.crru.ac.th/601463046/apidoctor/countgg.php?&text=$text&group_id=$grgr&isAdd=true';
        await Dio().get(url).then((value) => {print('coutsym22 = $value')});
        Response response = await Dio().get(url);
        String sn = "";
        if (response.toString() == 'null') {
          coutsym2NoBf();
        } else {
          var result = json.decode(response.data);
          print("resultidarray2$result");
          setState(() {
            for (var x in result) {
              symName.add(x['symptom_name']);
            }

            for (var s in symName) {
              sn = s;
            }
            for (var x in result) {
              dis2.add(x['disease_id']);
            }
            for (var x in result) {
              sym2.add(x['symptom_id']);
            }
            String snn = "";
            for (var s in sym2) {
              snn = s;
            }
            print(snn);
            for (var x in result) {
              status2.add(x['status']);
            }
            for (var x in result) {
              ynn.add(x['yn']);
            }
            for (var x in result) {
              imgs.add(x['img']);
            }
            for (var x in imgs) {
              img = x;
            }
            for (var x in result) {
              bf.add(x['before_id']);
            }
            for (var x in bf) {
              before = x;
            }
            iii = img;
            print(img);
            print(sn);
            symptomName = sn;
            symptomId = snn;
          });
          // await findbf();
        }
      }
    }
  }

  Future<Null> coutsym2NoBf() async {
    await count();
    if (d == 0) {
      getDis2();
    } else {
      String text = "";
      int cnum = disNoBf.length;
      int i = 1;
      for (var x in disNoBf) {
        if (i == cnum) {
          text = text + x;
        } else {
          text = text + x + ",";
        }
        i++;
      }
      print("ล่าสุด=$text");

      String grgr = "";
      int cnum3 = grNoBf.length;
      int i3 = 1;
      for (var x in grNoBf) {
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
          iii = '';
        });

        String url =
            'http://student.crru.ac.th/601463046/apidoctor/idarray2.php?&text=$text&isAdd=true';
        await Dio().get(url).then((value) => {print('coutsym2 = $value')});
        Response response = await Dio().get(url);
        var result = json.decode(response.data);
        print("resultidarray2$result");
        String sn = "";
        setState(() {
          for (var x in result) {
            symName.add(x['symptom_name']);
          }
          String sn = "";
          for (var s in symName) {
            sn = s;
          }
          for (var x in result) {
            dis2.add(x['disease_id']);
          }
          for (var x in result) {
            sym2.add(x['symptom_id']);
          }
          String snn = "";
          for (var s in sym2) {
            snn = s;
          }
          print(snn);
          for (var x in result) {
            status2.add(x['status']);
          }
          for (var x in result) {
            ynn.add(x['yn']);
          }
          for (var x in result) {
            imgs.add(x['img']);
          }
          for (var x in imgs) {
            img = x;
          }
          for (var x in result) {
            bf.add(x['before_id']);
          }
          for (var x in bf) {
            before = x;
          }
          print(iii);
          print(symptomName);
          symptomName = sn;
          symptomId = snn;
          iii = img;
        });
        // await findbf();
      }
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

  Future<Null> getCountDis() async {
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/showSymYn.php?isAdd=true';
    Response response = await Dio().get(url);
    print('res=$response');
    if (response.toString() == 'null') {
      setState(() {
        cDis = 0;
        print("cDis null=$cDis");
      });
    } else {
      var result = json.decode(response.data);
      var cdd = new List();
      setState(() {
        for (var x in result) {
          cdd.add(x);
        }
        for (var x in result) {
          did.add(x['disease_id']);
        }
        for (var x in did) {
          did2 = x;
        }
        print("did2=$did2");
        cDis = cdd.length;
        print("d=$cDis");
        if (cDis == 1) {
          getCountDis2();
        }
      });
    }
  }

  Future<Null> getCountDis2() async {
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/showSymYn2.php?isAdd=true';
    Response response = await Dio().get(url);
    print('res=$response');
    if (response.toString() == 'null') {
      setState(() {
        // cDis2 = 0;
        print("cDis null=$cDis");
      });
    } else {
      var result = json.decode(response.data);
      var cdd2 = new List();
      var no = new List();
      setState(() {
        for (var x in result) {
          cdd2.add(x['disease_id']);
        }
        for (var x in result) {
          no.add(x['no']);
        }
        for (var x in no) {
          cDis3 = x;
        }
        cDis2 = cdd2.length;
        print("d=$cDis2");
        if (cDis2 >= int.parse(cDis3)) {
          getDis3();
        } else if (cDis2 < int.parse(cDis3)) {
          getDis2();
        }
      });
    }
  }

  Future<Null> idBF() async {
    setState(() {
      diss = [];
      symm = [];
      symName = [];
      sym2 = [];
      ynn = [];
      imgs = [];
      bf = [];
    });

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym2.php?symptom_id=$symptomId&isAdd=true';
    await Dio().get(url).then((value) => {print('idBF = $value')});
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

      symptomName = "";
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

      for (var x in result) {
        imgs.add(x['img']);
      }
      for (var x in imgs) {
        img = x;
      }

      for (var x in result) {
        bf.add(x['before_id']);
      }
      for (var x in bf) {
        before = x;
      }
    });
    updateYN();
  }

  Future<Null> idArray() async {
    symYNname.add(symptomName);
    limit = limit - 1;
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
          imgs = [];
          bf = [];
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

          for (var x in result) {
            imgs.add(x['img']);
          }
          for (var x in imgs) {
            img = x;
          }

          for (var x in result) {
            bf.add(x['before_id']);
          }
          for (var x in bf) {
            before = x;
          }
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
      print("text2ล่าสุด=$text3");
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
          iii = '';
        });

        String url =
            'http://student.crru.ac.th/601463046/apidoctor/apiSym33.php?&text=$text&group_id=$grgr&isAdd=true';
        await Dio().get(url).then((value) => {print('coutsym33 = $value')});
        Response response = await Dio().get(url);
        String sn = "";
        if (response.toString() == 'null') {
          coutsym();
        } else {
          var result = json.decode(response.data);
          setState(() {
            for (var x in result) {
              symName.add(x['symptom_name']);
            }

            for (var s in symName) {
              sn = s;
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
            for (var x in result) {
              imgs.add(x['img']);
            }
            for (var x in imgs) {
              img = x;
            }
            for (var x in result) {
              bf.add(x['before_id']);
            }
            for (var x in bf) {
              before = x;
            }

            print(sn);

            symptomId = snn;
            iii = img;
            print(iii);
          });
          await findbf();
          setState(() {
            if (a == "2") {
              symptomName = "...";
            } else {
              symptomName = sn;
            } //coutsymmmm()
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
          iii = '';
        });

        String url =
            'http://student.crru.ac.th/601463046/apidoctor/apiSym3.php?&text=$text&isAdd=true';
        await Dio().get(url).then((value) => {print('coutsym = $value')});
        Response response = await Dio().get(url);
        var result = json.decode(response.data);
        String snn = "";
        String sn = "";
        setState(() {
          for (var x in result) {
            symName.add(x['symptom_name']);
          }

          for (var s in symName) {
            sn = sn + s;
          }
          for (var x in result) {
            dis2.add(x['disease_id']);
          }
          for (var x in result) {
            sym2.add(x['symptom_id']);
          }

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
          for (var x in result) {
            imgs.add(x['img']);
          }
          for (var x in imgs) {
            img = x;
          }
          for (var x in result) {
            bf.add(x['before_id']);
          }
          for (var x in bf) {
            before = x;
          }
          symptomId = snn;
          iii = img;
        });
        await findbf();
        setState(() {
          symptomName = sn; // coutsym()
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
    limit = limit - 1;
    await getCountDis();
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
        imgs = [];
        bf = [];
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
        for (var x in result) {
          imgs.add(x['img']);
        }
        for (var x in imgs) {
          img = x;
        }
        for (var x in result) {
          bf.add(x['before_id']);
        }
        for (var x in bf) {
          before = x;
        }

        // findbf();
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
          iii = '';
          img = '';
        });

        String url =
            'http://student.crru.ac.th/601463046/apidoctor/countgg.php?&text=$text&group_id=$grgr&isAdd=true';
        await Dio().get(url).then((value) => {print('coutsym22 = $value')});
        Response response = await Dio().get(url);
        String sn = "";
        if (response.toString() == 'null') {
          coutsym2();
        } else {
          var result = json.decode(response.data);
          print("resultidarray2$result");
          setState(() {
            for (var x in result) {
              symName.add(x['symptom_name']);
            }

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
            for (var x in result) {
              imgs.add(x['img']);
            }
            for (var x in imgs) {
              img = x;
            }
            for (var x in result) {
              bf.add(x['before_id']);
            }
            for (var x in bf) {
              before = x;
            }
            iii = img;
            print(img);
            print(sn);
            // symptomName = sn;
            symptomId = snn;
          });
          // await findbf();
          setState(() {
            symptomName = sn;
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
    if (result.toString() == "null") {
      print("null");
    } else {
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
          iii = '';
        });

        String url =
            'http://student.crru.ac.th/601463046/apidoctor/idarray2.php?&text=$text&isAdd=true';
        await Dio().get(url).then((value) => {print('coutsym2 = $value')});
        Response response = await Dio().get(url);
        var result = json.decode(response.data);
        print("resultidarray2$result");
        String sn = "";
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
          for (var x in result) {
            imgs.add(x['img']);
          }
          for (var x in imgs) {
            img = x;
          }
          for (var x in result) {
            bf.add(x['before_id']);
          }
          for (var x in bf) {
            before = x;
          }
          print(iii);
          print(symptomName);
          symptomName = sn;
          symptomId = snn;
          iii = img;
        });
        // await findbf();
      }
    }
  }

  Future<Null> idArray32() async {
    // await getCountDis();
    limit = limit - 1;
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
        imgs = [];
        bf = [];
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
          grgr = x;
        }
        print("$grgr");

        for (var x in result) {
          imgs.add(x['img']);
        }
        for (var x in imgs) {
          img = x;
        }
        for (var x in result) {
          bf.add(x['before_id']);
        }
        for (var x in bf) {
          before = x;
        }
      });

      apiSym32_2();
    }
  }

  Future<Null> apiSym32_2() async {
    await count();

    setState(() {
      symName = [];
      sym2 = [];
      imgs = [];
      bf = [];

      if (limit <= 1) {
        limit = 2;
      } else if (limit >= 2) {
        limit = limit - 1;
      }
    });

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym322.php?&text=$limit&grgr=$grgr&isAdd=true';

    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    String sn = "";
    print("$result");
    print("$limit");
    if (response.toString() == 'null') {
      apiSym32();
    } else {
      setState(() {
        for (var x in result) {
          symName.add(x['symptom_name']);
        }

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
        for (var x in result) {
          imgs.add(x['img']);
        }
        for (var x in imgs) {
          img = x;
        }
        for (var x in result) {
          bf.add(x['before_id']);
        }
        for (var x in bf) {
          before = x;
        }
        print(iii);
        print(sn);

        symptomName = sn;
        symptomId = snn;
        iii = img;
      });
      await findbf();
      await updateU();
      setState(() {
        symptomName = sn; //apiSym32
      });

      limit = 0;
    }
  }

  Future<Null> apiSym32() async {
    await count();
    setState(() {
      symName = [];
      sym2 = [];
      imgs = [];
      bf = [];
      if (limit <= 1) {
        limit = 2;
      } else if (limit >= 2) {
        limit = limit - 1;
      }
    });

    String url =
        'http://student.crru.ac.th/601463046/apidoctor/apiSym32.php?&text=$limit&isAdd=true';

    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    String sn = "";
    print("$result");
    print("$limit");
    if (response.toString() == 'null') {
      getCountDis();
    } else {
      setState(() {
        for (var x in result) {
          symName.add(x['symptom_name']);
        }

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
        for (var x in result) {
          imgs.add(x['img']);
        }
        for (var x in imgs) {
          img = x;
        }
        for (var x in result) {
          bf.add(x['before_id']);
        }
        for (var x in bf) {
          before = x;
        }
        print(iii);
        print(sn);

        symptomId = snn;
        iii = img;
      });

      await findbf();
      await updateU();
      setState(() {
        symptomName = sn; //apiSym32
      });

      limit = 0;
    }
  }

  Future<Null> updateU() async {
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
        'http://student.crru.ac.th/601463046/apidoctor/updateU.php?&$tt1&$tt2&$tt3&$tt4&isAdd=true';
    await Dio().get(url).then((value) => {print('updateU = $value')});
  }

  Future<Null> updateStatusBf() async {
    print("$before");
    String url =
        'http://student.crru.ac.th/601463046/apidoctor/updateBf.php?&before_id=$before&idbf=$idbf&isAdd=true';
    await Dio().get(url).then((value) => {print('updateStatusBf = $value')});
    findId();
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    symptomName == "..."
                        ? MyStyle().showProgress()
                        : a == "0" ? symFrist() : sym(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(('อาการที่คุณตอบใช่'),
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.pink[700],
                            fontFamily: 'Prompt',
                          )),
                    ),
                    symYNname.length == 0
                        ? MyStyle().ss()
                        : Padding(
                            padding: const EdgeInsets.all(15),
                            child: SizedBox(
                              height: 200,
                              child: new ListView.builder(
                                itemCount: symYNname.length,
                                itemBuilder: (context, index) {
                                  return an_builder(context, index);
                                },
                              ),
                            ),
                          )
                  ]))),
    );
  }

  Widget an_builder(context, index) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 10, top: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "- " + symYNname[index],
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Prompt',
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget symFrist() => Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        child: Card(
          color: Colors.white,
          child: Container(
            constraints:
                BoxConstraints(minHeight: 100, minWidth: double.infinity),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20, right: 20, bottom: 20),
                    child: Text(("$namebef"),
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
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: RaisedButton(
                            onPressed: () {
                              idbf = '1';
                              updateStatusBf();
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
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: RaisedButton(
                            onPressed: () {
                              idbf = '2';
                              updateStatusBf();
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
                      )
                    ],
                  ),
                ]),
          ),
        ),
      ));
  Widget sym() => a == "0"
      ? symFrist()
      : Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SizedBox(
            child: Card(
              color: Colors.white,
              child: Container(
                constraints:
                    BoxConstraints(minHeight: 100, minWidth: double.infinity),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: Text(("$symptomName"),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontFamily: 'Prompt',
                            )),
                      ),
                      iimage(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
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
                            padding: const EdgeInsets.only(bottom: 20),
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
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: RaisedButton(
                                onPressed: () {
                                  // apiSym32();
                                  idArray32();
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
  Widget symList() => Container(
        child: SizedBox(
          width: 330,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Card(
              color: Colors.white,
              child: Container(
                constraints:
                    BoxConstraints(minHeight: 100, minWidth: double.infinity),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(('อาการที่คุณตอบใช่'),
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.pink[700],
                              fontFamily: 'Prompt',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, bottom: 20),
                        child: Text(('$symYname ' ?? '...'),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                              fontFamily: 'Prompt',
                            )),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      );
  Widget iimage() => iii == "null"
      ? Container()
      : Container(
          child: SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.network('$iii'),
            ),
          ),
        );
}
