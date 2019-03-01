import 'package:flutter/material.dart';
import 'package:iridescentangle/utils/HttpUtil.dart';
import 'package:iridescentangle/net/HttpService.dart';
import 'package:flutter/cupertino.dart';
import 'package:iridescentangle/utils/ColorUtil.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:iridescentangle/tec/tec_web_page.dart';
import '../widget/SearchEmptyView.dart';
class SearchResultPage extends StatefulWidget {
  String name;
  SearchResultPage({Key key,this.name}):super(key:key);
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  String url = HttpService.WANANDROID_SEARCH;
  List data = List();
  bool _noResult = true;
  bool _refresh = false;
  ScrollController _controller = ScrollController();
  int page = 0;
  @override
  void initState() {
    super.initState();
    _controller.addListener((){
      if(_controller.position.pixels == _controller.position.maxScrollExtent){
        page ++;
        _search();
      }
    });
    _search();
  }
  @override
  void dispose() {
    // TODO: implement dispose
     _controller.dispose();
    super.dispose();
  }
  void _search() async {
    Map<String,String> map =Map();
    map['k'] =widget.name;
    HttpUtil.post(url.replaceAll('~', page.toString()),(data){
      List datas = data['datas'];
      if(datas != null && datas.length > 0){
        setState(() {
          if(_refresh){
            this.data.clear();
            this.data.addAll(datas);
            _refresh = false;
            return;
          }
          _noResult = false;
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
    if(_refresh){
      return Center(child:CircularProgressIndicator());
    }
    if (_noResult) {
      return SearchEmptyView();
    }else{
      return RefreshIndicator(
        onRefresh: (){
          setState(() {
            _refresh = true;
          });
          page = 0;
          _search();
        },
          child:ListView(
          controller: _controller,
          children:
          data.map((item){
            String pureTitle = item['title'].toString().replaceAll('<em class=\'highlight\'>', '').replaceAll('</em>', '');
            return Card(
                elevation: 1.0,
                child: buildItem(context,item,pureTitle),
            );
          }
          ).toList(),
        ),
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
    return SearchEmptyView();
  }
}