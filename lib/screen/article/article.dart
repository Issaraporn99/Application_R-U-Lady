import 'package:flutter/material.dart';

class Article extends StatefulWidget {
  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บทความ'),
      ),
      body: Container(
        decoration: BoxDecoration(
        
        ),
      ),
    );
  }
}
