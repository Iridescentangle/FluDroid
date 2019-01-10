import 'package:flutter/material.dart';
import 'package:sky_engine/_http/http.dart';
class NewsPage extends StatefulWidget {
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String news_key = "7a0230bb21ce9199928f22ff044b8d34";
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text('新闻'),
    );
  }
}