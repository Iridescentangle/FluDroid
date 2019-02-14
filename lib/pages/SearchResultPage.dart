import 'package:flutter/material.dart';
class SearchResultPage extends StatefulWidget {
  String name;
  SearchResultPage({Key key,this.name}):super(key:key);
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //  child: child,
      child: Text(widget.name),
    );
  }
}