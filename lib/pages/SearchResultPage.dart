import 'package:flutter/material.dart';
import 'package:iridescentangle/utils/HttpUtil.dart';
import 'package:iridescentangle/net/HttpService.dart';
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
    if (!_noResult) {
      return Center(
        child: Image.asset('assets/images/no_data.png',),
      );
    }else{

    }
    return Container();
  }
}