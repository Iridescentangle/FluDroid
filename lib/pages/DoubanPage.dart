import 'package:flutter/material.dart';
import 'package:flustars/src/screen_util.dart';
import 'DoubanTop250Page.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
class DoubanPage extends StatefulWidget {
  _DoubanPageState createState() => _DoubanPageState();
}

class _DoubanPageState extends State<DoubanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('豆瓣电影'),),
      body: Column(
        children: <Widget>[
          _doubanTop250(context),
          _doubanHot(context),
        ],
      ),
    );
  }
  Widget _doubanTop250(BuildContext context){
    var width = ScreenUtil.getInstance().screenWidth;
    return Card(
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>DoubanTop250Page()
                  ));
                },
                leading: Icon(Icons.movie),
                title: Text('豆瓣Top250',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
              ),
            );
  }
  Widget _doubanHot(BuildContext context){
    return Card(
      child: ListTile(
        onTap: (){

        },
        leading: Icon(Icons.flag),
        title: Text('豆瓣热映',style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
      ),
    );
  }
}