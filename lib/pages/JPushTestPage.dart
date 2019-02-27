import 'package:flutter/material.dart';
class JPushTestPage extends StatefulWidget {
  final Widget child;

  JPushTestPage({Key key, this.child}) : super(key: key);

  _JPushTestPageState createState() => _JPushTestPageState();
}

class _JPushTestPageState extends State<JPushTestPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: widget.child,
    );
  }
}