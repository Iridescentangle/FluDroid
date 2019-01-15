import 'package:flutter/material.dart';
import 'package:flustars/src/screen_util.dart';
import 'DoubanTop250Page.dart';
import 'dart:ui';
class DoubanPage extends StatefulWidget {
  _DoubanPageState createState() => _DoubanPageState();
}

class _DoubanPageState extends State<DoubanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('豆瓣电影'),),
      body: Column(
        children: <Widget>[
          _doubanTop250(context),
          
        ],
      ),
    );
  }
  Widget _doubanTop250(BuildContext context){
    var width = ScreenUtil.getInstance().screenWidth;
    return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>DoubanTop250Page()
              ));
            },
            child: Container(
              width: width,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.network('https://i.loli.net/2019/01/15/5c3db1a88ab5c.png'),
                  Center(
                    child: ClipRect(  //裁切长方形
                      child: BackdropFilter(   //背景滤镜器
                        filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0), //图片模糊过滤，横向竖向都设置5.0
                        child: Opacity( //透明控件
                          opacity: 0.2,
                          child: Container(// 容器组件
                            width: width,
                            decoration: BoxDecoration(color:Colors.grey.shade200), //盒子装饰器，进行装饰，设置颜色为灰色
                            child: Center(
                              child: Text(
                                '豆瓣Top250',
                                style: Theme.of(context).textTheme.display3, //设置比较酷炫的字体
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                   ),
                  // Positioned(
                  //   child: Center(
                  //     child: Text('豆瓣Top250',style: TextStyle(color: Colors.white,fontSize: 30.0),),
                  //   ),
                  // ),
                ],
              ),
            ),
            
          );
  }
}