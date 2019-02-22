import 'package:flutter/material.dart';
import 'package:iridescentangle/utils/HttpUtil.dart';
import 'package:iridescentangle/net/HttpService.dart';
import 'package:flutter/cupertino.dart';
import 'package:iridescentangle/utils/ColorUtil.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:iridescentangle/tec/tec_web_page.dart';
class SearchResultPage extends StatefulWidget {
  String name;
  SearchResultPage({Key key,this.name}):super(key:key);
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  String url = HttpService.WANANDROID_SEARCH;
  List data = List();
  bool _noResult = true;
  @override
  void initState() {
    super.initState();
    _search();
  }
  void _search() async {
    Map<String,String> map =Map();
    map['k'] =widget.name;
    HttpUtil.post(url.replaceAll('~', '0'),(data){
      List datas = data['datas'];
      if(datas != null && datas.length > 0){
        setState(() {
          _noResult = false;
          this.data.clear();
          this.data.addAll(datas);
        });
      };
    },params: map,
    errorCallback:(e){
      print(e);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name),centerTitle: true,),
      body: _renderBody(),
    );
  }
  Widget _renderBody(){
    if (_noResult) {
      return SearchEmptyView();
    }else{
      return ListView(
        children: 
        data.map((item){
          String pureTitle = item['title'].toString().replaceAll('<em class=\'highlight\'>', '').replaceAll('</em>', '');
          return Card(
              elevation: 1.0,
              child: buildItem(context,item,pureTitle),
          );
        }
        ).toList(),
      );
    }
  }
  Widget buildItem(BuildContext context,item,title){
    return Container(
             margin: EdgeInsets.only(top: 0.0),
            child: new ListTile(
                   onTap: (){
                     Navigator.push(context, CupertinoPageRoute(builder: (context){
                       return TecWebDetailPage(item['link'], title,id: item['id'],collected: item['collect'],);
                     }));
                   },
                   title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                      Text(title,style: TextStyle(fontSize:15.0,fontWeight: FontWeight.bold),),
                      Container(height: 40.0,),
                      Text(item['author'] + '   '+item['niceDate'],style: TextStyle(fontSize: 12.0,color: Colors.grey),)
                   ],),
                   trailing: CircleAvatar(
                     radius: 28.0,
                     backgroundColor: ColorUtil.primary.random(Random()),
                     child: new Padding(
                       padding: EdgeInsets.all(5.0),
                       child: new Text(
                         item['tags'].length == 0?'':item['tags'][0]['name'],
                         textAlign: TextAlign.center,
                         style: TextStyle(color: Colors.white, fontSize: 11.0),
                       ),
                     ),
                   ),
                 ),
    );
  }
}
class SearchEmptyView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 130.0,
              height: 100.0,
              child: Image.asset('assets/images/no_data.png',),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('没有搜索到结果，换个词试试?',style:Theme.of(context).textTheme.subhead),
            ),
          ],
        ),
      );
  }
}