import 'package:flutter/material.dart';
class SearchResultPage extends StatefulWidget {
  String name;
  SearchResultPage({Key key,this.name}):super(key:key);
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name),),

    );
  }
}