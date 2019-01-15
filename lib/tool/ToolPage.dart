import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
import 'package:flustars/src/screen_util.dart';
import 'dart:ui';
import 'package:iridescentangle/pages/DoubanPage.dart';
class ToolPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: <Widget>[
        _doubanTool(context),
      ],
    );
  }
  Widget _doubanTool(BuildContext context){
    double width = ScreenUtil.getInstance().screenWidth;
    return GestureDetector(
        onTap: (){
         Navigator.push(context,MaterialPageRoute(
           builder: (context)=>DoubanPage()
         ));
        },
        child:
         Card(
            margin: EdgeInsets.all(10.0),
            elevation: 2.0,
            child: Container(
              width: width-20,
              height: 100.0,
              child: Center(
                child: Text('豆瓣电影',style: TextStyle(color: Colors.black87,fontSize: 20.0),),),
            ),
          ),
        );
  }
}