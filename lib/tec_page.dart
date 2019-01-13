import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
// import 'package:sky_engine/_http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'bean/tec_bean.dart';

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
      _body_list = List();
      pageUrl = "http://www.wanandroid.com/article/list/${page}/json";
      loadData(page);
    }
  void loadData(int page) async{
    http.Response response1 = await http.get(topUrl);
    var result1 = await json.decode(response1.body);
    http.Response response2 = await http.get(pageUrl);
    var result2 = await json.decode(response2.body);
    if(result1['errorCode'] == 0){
      _body_list.addAll(result1['data']);
    }
    if(result2['errorCode'] == 0){
      if(result2['data']['size'] == 20){
        _body_list.addAll(result2['data']['datas']);
      }
    }
    // print(result2.runtimeType);
    setState(() {
          
        });
  }
  @override
  Widget build(BuildContext context) {
    // if(_body_list != null || _body_list.length <= 0){
    if(_body_list == null || _body_list.length == 0){
      return Center(child: CupertinoActivityIndicator(),);
    }else{
      return ListView.builder(
            itemBuilder: _renderTile,
            itemCount: _body_list.length,
          );
    }
  }
  Widget _renderTile(BuildContext context,int index){
    Map<String, dynamic> item = _body_list[index];
    // Map<String ,dynamic> map = json.decode(itemJson);
  //  Data data = Data.fromJson(json.decode(itemJson));
    return ListTile(
      title: Card(
        color: Colors.white,
        elevation: 4.0,
        child: Row(
          children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: new Border.all(width: 1.0, color: Colors.red,),
                            borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                            color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child:
                            Text('置顶'),
                          ),
                      ),
                      Text('${item['author']}'),
                    ],
                  ),
                  
                ],
              ),
          ],
        )
      ),
    );
  }
}