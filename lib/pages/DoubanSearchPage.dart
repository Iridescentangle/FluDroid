import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class DoubanSearchPage extends StatefulWidget {
  _DoubanSearchPageState createState() => _DoubanSearchPageState();
}

class _DoubanSearchPageState extends State<DoubanSearchPage> {
  TextEditingController _textController =TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                title: TextField(
                  decoration: InputDecoration(hintText: '请输入要搜索的电影名',fillColor: Colors.white),
                  maxLines: 1,
                  // decoration: InputDecoration.collapsed(hintText: '请输入您要搜索的电影名称',fillColor: Colors.white),
                  cursorColor: Colors.white,
                    controller: _textController,
                  ),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _search,
                  ),
                ],
              ),
      body: _body(context),
        
    );
  }
  void _search(){

  }
  Widget _body(context){

  }
}