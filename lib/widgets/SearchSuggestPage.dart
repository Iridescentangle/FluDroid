import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SearchSuggestPage extends StatefulWidget {
  final Widget child;

  SearchSuggestPage({Key key, this.child}) : super(key: key);

  _SearchSuggestPageState createState() => _SearchSuggestPageState();
}

class _SearchSuggestPageState extends State<SearchSuggestPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: widget.child,
    );
  }
}