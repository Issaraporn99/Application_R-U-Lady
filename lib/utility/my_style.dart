import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Colors.blue.shade800;
  Color primaryColor = Colors.grey[200];

  SizedBox mySizeBox() => SizedBox(width: 8.0,height: 16.0,);
 

  Text showTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 22.0,
          color: Colors.blue.shade800,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showTitleH2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.blue.shade500,
          fontWeight: FontWeight.bold,
        ),
      );

        Text menuHome(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );



  Container showLogo() {
    return Container(
      width: 290.0,
      child: Image.asset('images/7.png'),
    );
  }

    Container showLogoLogin() {
    return Container(
      width: 250.0,
      child: Image.asset('images/login.png'),
    );
  }

   Container showImgHome() {
    return Container(
      width: 180,
      child: Image.asset('images/home.png'),
    );
  }
  Container showImgEx() {
    return Container(
      width: 200.0,
      child: Image.asset('images/as.jpg'),
    );
  }
  MyStyle();
}
