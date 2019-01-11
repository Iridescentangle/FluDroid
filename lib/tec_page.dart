import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
      // TODO: implement initState
      super.initState();
      pageUrl = "http://www.wanandroid.com/article/list/${page}/json";
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