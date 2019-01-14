import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';
class TecWebDetailPage extends StatelessWidget {
  final String url;
  final String title;

  TecWebDetailPage(this.url, this.title);

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      withJavascript: true,
      url: url,
      scrollBar:true,
      withLocalUrl: true,
      appBar: new AppBar(
        title: Text(title),
      ),
    );
  }
}
