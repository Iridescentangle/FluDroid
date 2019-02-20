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
    if (_noResult) {
      return SearchEmptyView();
    }else{
      return ListView(
        children: 
        data.map((item){
          return Container(
            child: Text('${item['author']}:${item['title']}',style: TextStyle(color: Colors.black,fontSize: 20.0),overflow: TextOverflow.ellipsis,),
          );
        }
        ).toList(),
      );
    }
    return Container();
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