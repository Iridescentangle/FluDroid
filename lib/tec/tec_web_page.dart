import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class TecWebDetailPage extends StatelessWidget {
  final String url;
  final String title;

  TecWebDetailPage(this.url, this.title);

  @override
  Widget build(BuildContext context) {
    // return new WebviewScaffold(
    //   withJavascript: true,
    //   url: url,
    //   scrollBar:true,
    //   withLocalUrl: true,
    //   appBar: new AppBar(
    //     title: Text(title),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
