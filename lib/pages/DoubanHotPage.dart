import 'package:flutter/material.dart';
class DoubanHotPage extends StatefulWidget {
  _DoubanHotPageState createState() => _DoubanHotPageState();
}

class _DoubanHotPageState extends State<DoubanHotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('豆瓣热映'),),
      body: _body(context),
    );
  }
  Widget _body(context){
    return Container();
  }
}