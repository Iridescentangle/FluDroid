import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
import 'package:flustars/src/screen_util.dart';
import 'dart:ui';
import 'package:iridescentangle/pages/DoubanPage.dart';
import '../pages/WanAndroidPage.dart';
import 'package:iridescentangle/page_routes/FadePageRoute.dart';
import 'package:iridescentangle/pages/weather_page.dart';
import 'package:iridescentangle/pages/MoviePage.dart';
import 'package:iridescentangle/pages/JPushTestPage.dart';
class ToolPage extends StatelessWidget {
  double width;
  @override
  Widget build(BuildContext context) {
    width = ScreenUtil.getInstance().screenWidth;
    return Column(
      children: <Widget>[
        _buildItem(context, '豆瓣电影', (){
           Navigator.push(context,MaterialPageRoute(
           builder: (context)=>DoubanPage()
         ));
        }),
        _buildItem(context,'天气',(){
          Navigator.push(context, 
            FadePageRoute(WeatherPage())
          );
        }),
        _buildItem(context, '电影详情', (){
          Navigator.push(context, FadePageRoute(JPushTestPage()));
        }),
      ],
    );
  }
  
  Widget _buildItem(BuildContext context,String title,Function onTap){
    return GestureDetector(
        onTap: (){
         onTap();
        },
        child:
         Card(
            margin: EdgeInsets.all(10.0),
            elevation: 2.0,
            child: Container(
              width: width-20,
              height: 100.0,
              child: Center(
                child: Text(title,style: TextStyle(color: Colors.black87,fontSize: 20.0),),),
            ),
          ),
        );
  }
}