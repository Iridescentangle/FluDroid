import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sky_engine/_http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:ui';
class TecPage extends StatefulWidget {
  _TecPageState createState() => _TecPageState();
}

class _TecPageState extends State<TecPage> {
  List<Object> _body_list;
  int page = 0;
  var topUrl = "http://www.wanandroid.com/article/top/json";
  var pageUrl ;
  @override
    void initState() {
      super.initState();
      pageUrl = "http://www.wanandroid.com/article/list/${page}/json";
      loadData(page);
    }
  void loadData(int page){
    var client = http.HttpClient();
    // var request =await client.getUrl(pageUrl);
    // // var request = await httpClient.getUrl(uri1);
    // var response = await request.close();
    // var responseBody = await response.transform(utf8.decoder).join();
    // var result = json.decode(responseBody);
    // print(result)
  }
  @override
  Widget build(BuildContext context) {
    // if(_body_list != null || _body_list.length <= 0){
    if(_body_list != null){
      return Center(child: CupertinoActivityIndicator(),);
    }else{
      return ListView.builder(
            itemBuilder: _renderTile,
            // itemCount: _body_list.length,
            itemCount: 10,
          );
    }
  }
  Widget _renderTile(BuildContext context,int index){
    return ListTile(
      leading: Card(
        elevation: 4.0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('我是条目'),
        ),
      ),
    );
  }
}