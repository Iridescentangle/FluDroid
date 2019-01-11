import 'package:flutter/material.dart';
import 'package:sky_engine/_http/http.dart';
import 'package:flutter/cupertino.dart';
class NewsPage extends StatefulWidget {
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String news_key = "7a0230bb21ce9199928f22ff044b8d34";
  List _articleList;
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      // loadData(0);
    }
  @override
  Widget build(BuildContext context) {
    if(_articleList == null || _articleList.length == 0){
      return Center(child:CupertinoActivityIndicator());
    }else{
      return Container(
        child: Text('新闻'),
      );
    }
  }
}