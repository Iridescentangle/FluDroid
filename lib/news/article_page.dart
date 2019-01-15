import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:iridescentangle/model/ArticleInfo.dart';
class ArticlePage extends StatefulWidget {
  String type;
  String name;
  ArticlePage({Key key,this.type,this.name}):super(key:key);
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<ArticleInfo> list = List<ArticleInfo> ();
  final String news_key = "7a0230bb21ce9199928f22ff044b8d34";
  int errorCode = 0;
  @override
    void initState() {
      super.initState();
      getData();
    }
  void getData() async{
    var url  = "http://v.juhe.cn/toutiao/index?type=${widget.type}&key=$news_key";
    await http.get(url).then((http.Response response){
      Article_Tree tree = Article_Tree.fromJson(json.decode(response.body));
      if(tree.error_code == 10012){
        setState(() {
                  errorCode = 10012;
                });
      }
      if(tree != null && tree.error_code == 0 && tree.result.stat == "1"){
        setState(() {
                  list.clear();
                  list.addAll(tree.result.data);
                });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    if(errorCode == 10012){
      return Center(
        child: Text('服务器今日负荷已经耗尽，请明天再试哦!',style: TextStyle(color: Colors.black54,fontSize: 20.0),),
      );
    }
    if(list.length == 0){
      return Center(
       child: CircularProgressIndicator(),
      );
    }else{
      return ListView.builder(
        itemCount: list.length,
        itemBuilder: _renderListItem,
      );
    }
  }
  Widget _renderListItem(BuildContext context,int index){
    ArticleInfo item = list[index];
    return ListTile(
      title: Card(
        elevation: 3.0,
        child: Container(
          width: 500.0,
          height: 140.0,
          child: Stack(
            children: <Widget>[
              _rendTag(item.category),
              _rendTitle(item.title,index),
              _rendAuthor(item.author_name),
              _rendImg(item.thumbnail_pic_s,item.thumbnail_pic_s02,item.thumbnail_pic_s03),
              _rendDate(item.date),
            ],
          ),
        ),
      ),
    );
  }
  Widget _rendTitle(String title,int index){
    return Positioned(
      top: 40.0,
      left: 10.0,
      child: Container(
        width:250.0,
        height: 50.0,
        child:Text(title,style: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold),),),
    );
  }
  Widget _rendTag(String tag){
    return Positioned(
      top: 10.0,
      left: 10.0,
      child: Text(tag,style: TextStyle(color: Colors.grey,fontSize: 12.0),),
    );
  }
  Widget _rendAuthor(String author){
    return Positioned(
      bottom: 10.0,
      left: 10.0,
      child: Text(author,style:TextStyle(color:Colors.black87,fontSize:12.0)),
    );
  }
  Widget _rendImg(String img1,String img2,String img3){
    return Positioned(
      right: 10.0,
      top: 20.0,
      child: Row(
        children: <Widget>[
          Container(
            width: 80.0,
            height: 60.0,
            child: getImg(img1),
          ),
          Container(width: 2.0,height: 60.0,decoration: BoxDecoration(color: Colors.white),),
          Column(
            children: <Widget>[
              Container(
                width: 40.0,
                height: 30.0,
                child: getImg(img2),
              ),
              Container(
                width: 40.0,
                height: 30.0,
                child: getImg(img3),
              )
            ],
          ),
        ],
      ),
    );
  }
  Widget getImg(String url){
    if(url != null){
      return  Image.network(url);
    }
    return null;
  }
  Widget _rendDate(String date){
    return Positioned(
      bottom: 10.0,
      right: 10.0,
      child: Text(date,style:TextStyle(color:Colors.black87,fontSize: 12.0)),
    );
  }
}