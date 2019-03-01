import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_search_panel/search_page.dart';
import 'dart:ui';
class DoubanSearchPage extends StatefulWidget {
  _DoubanSearchPageState createState() => _DoubanSearchPageState();
}

class _DoubanSearchPageState extends State<DoubanSearchPage> {
  TextEditingController _textController =TextEditingController();
  TextField textField;
  String keyWord = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _textController.addListener(
      (){
        String text =_textController.text;
        
      }
    );
    textField = TextField(
                  decoration: InputDecoration(hintText: '请输入要搜索的电影名',fillColor: Colors.white),
                  maxLines: 1,
                  // decoration: InputDecoration.collapsed(hintText: '请输入您要搜索的电影名称',fillColor: Colors.white),
                  cursorColor: Colors.white,
                    controller: _textController,
                  );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
       appBar: PreferredSize(
        child: AppBar(
                title: textField,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: ()=>_textController.clear(),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _search,
                  ),
                ],
              ),
        preferredSize: Size.fromHeight(55.0)),
      body: _body(context),
        
    );
  }
  void _search(){

  }
  Widget _body(context){
    if(_textController.text.length > 0){
      var statusBarHeight = MediaQueryData.fromWindow(window).padding.top;
      return Container(
        // child:FlutterSearchPanel(
        //     padding: EdgeInsets.all(10.0),
        //     selected: 'a',
        //     title: 'Demo Search Page',
        //     data: ['This', 'is', 'a', 'test', 'array'],
        //     icon: new Icon(Icons.check_circle, color: Colors.white),
        //     color: Colors.blue,
        //     textStyle: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0, decorationStyle: TextDecorationStyle.dotted),
        //     onChanged: (value) {
        //       print(value);
        //     },
        //   ),
        child:SearchPage(
          padding: EdgeInsets.all(10.0),
          data:['This', 'is', 'a', 'test', 'array'],
        )
      );
    }else{
      return Container();
    }
  }
}
