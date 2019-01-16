import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class ArticleDetailPage extends StatelessWidget {
  String url;
  String title;
  ArticleDetailPage({Key key,this.url,this.title}):super(key:key);
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