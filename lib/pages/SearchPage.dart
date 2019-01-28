import 'package:flutter/material.dart';
class SearchPage extends StatefulWidget {
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          
          autofocus: true,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: '请输入您要搜索的内容',
            fillColor: Colors.white,
          ),
        ),
      ),
      
    );
  }
}