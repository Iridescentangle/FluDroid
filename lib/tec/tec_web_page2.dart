import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class TecWebDetailPage2 extends StatelessWidget {
  final String url;
  final String title;

  TecWebDetailPage2(this.url, this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
