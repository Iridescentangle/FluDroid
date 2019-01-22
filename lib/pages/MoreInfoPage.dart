import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class MoreInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }
  Widget _body(BuildContext context){
    return  Center(
          child: new InkWell(
              child: new Text('Open Browser'),
              onTap: () => UrlLauncher.launch(
                  'https://docs.flutter.io/flutter/services/UrlLauncher-class.html')),
        );
  }
}