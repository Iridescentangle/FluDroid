import 'package:flutter/material.dart';
import 'DoubanTop250Page.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:iridescentangle/pages/DoubanSearchPage.dart';
class DoubanPage extends StatefulWidget {
  _DoubanPageState createState() => _DoubanPageState();
}

class _DoubanPageState extends State<DoubanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('豆瓣电影'),centerTitle: true,),
      body: Column(
        children: <Widget>[
          _buildItem(context,Icons.movie,'豆瓣TOP250',(){
            Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>DoubanTop250Page()
                              ));
          }),
          _buildItem(context,Icons.flag,'豆瓣热映',(){
            Navigator.push(context, 
              MaterialPageRoute(
                 builder: (context) => DoubanHotPage
              ),
            );
          }),
          _buildItem(context, Icons.search, '豆瓣电影搜索', (){
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context)=> DoubanSearchPage()
            ));
          }),
        ],
      ),
    );
  }
  Widget _buildItem(BuildContext context,iconData,title,onTap){
    return Card(
      child:Container(
        alignment: Alignment.center,
        height: 100.0,
        child: ListTile(
          onTap: onTap,
          leading: Icon(iconData),
          title: Text(title,style: TextStyle(fontSize: 20.0,),),
        ),
      ),
    );
  }
}