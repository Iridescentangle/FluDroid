import 'package:flutter/material.dart';
class MoreInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('关于本项目'),
      ),
    );
  }
}