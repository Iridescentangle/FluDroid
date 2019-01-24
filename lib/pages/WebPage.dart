import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebPage extends StatelessWidget {
  String url;
  String title;
  WebPage(this.url,this.title);
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