import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:iridescentangle/utils/ToastUtil.dart';
import 'WebPage.dart';
class MoreInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('关于'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _body(context),
    );
  }
  Widget _body(BuildContext context){
    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.lightBlue),
          height: 150.0,
          child: Center(
            child:Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: FlutterLogo(
                    size: 60.0,
                    colors: Colors.red, // 图的颜色
                    textColor: Colors.orange, // 只对带文字的style起作用
                    style: FlutterLogoStyle.markOnly,  // 只有图
                    curve: Curves.elasticOut,  
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child:Text('FluDroid 0.1.0',style: TextStyle(color: Colors.white,fontSize: 20.0),)
                ),
              ],
            )
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(color:Colors.grey.shade200),
          height: 40.0,
          child: Padding(padding:EdgeInsets.all(10.0),child:Text('简介',style:TextStyle(color:Colors.grey)),),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child:
          Text.rich(
            new TextSpan(
            style: new TextStyle(
              letterSpacing: 0.5,
              fontSize: 17.0,
              color: Colors.grey.shade800,
            ),
            children: [
              TextSpan(
                text: "FluDroid ",
                style: new TextStyle(
                  fontSize: 17.0,
                  color: Colors.blue,
                 fontWeight: FontWeight.bold,
                ),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () =>
                      launch('https://github.com/Iridescentangle/FluDroid'),),
              TextSpan(
                text: "是一个Flutter学习的练手项目,从零开始学起.\n在",
              ),
              TextSpan(
                  text: " 技术胖 ",
                  style: new TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold
                  ),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                     launch('http://jspang.com/');
                    }
              ),
              TextSpan(
                text: '的帮助下,入门了Flutter.感谢技术胖,感谢每一个热爱Flutter的大佬.',
              )
            ],
          ),)
        ),
         Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(color:Colors.grey.shade200),
          height: 40.0,
          child: Padding(padding:EdgeInsets.all(10.0),child:Text('Flutter开源项目',style:TextStyle(color:Colors.grey)),),
        ),
        Column(
          children: <Widget>[
            _repositoryItem('Flutter官方','https://github.com/flutter/flutter','Flutter makes it easy and fast to build beautiful mobile apps',context),
            _repositoryItem('Solido/awesome-flutter','https://github.com/Solido/awesome-flutter',
            'An awesome list that curates the best Flutter libraries, tools, tutorials, articles and more.'
            ,context),
            _repositoryItem('alibaba/flutter-go','https://github.com/alibaba/flutter-go',
            'flutter 开发者帮助 APP，包含 flutter 常用 140+ 组件的demo 演示与中文文档'
            ,context),
            _repositoryItem('CarGuo/GSYGithubAppFlutter','https://github.com/CarGuo/GSYGithubAppFlutter',
            '超完整的Flutter项目，功能丰富，适合学习和日常使用',
            context),
            _repositoryItem('iampawan/FlutterExampleApps','https://github.com/iampawan/FlutterExampleApps',
            '[Example APPS] Basic Flutter apps, for flutter devs.',
            context),
            _repositoryItem('The History of Everything','https://github.com/2d-inc/HistoryOfEverything',
            'Flutter Launch Timeline Demo',
            context),
            _repositoryItem('AweiLoveAndroid/Flutter-learning','https://github.com/AweiLoveAndroid/Flutter-learning',
            'Flutter安装和配置，Flutter开发遇到的难题，Flutter示例代码和模板，Flutter项目实战，Dart语言学习示例代码',
            context),
            _repositoryItem('Sky24n/flutter_wanandroid','https://github.com/Sky24n/flutter_wanandroid',
            'Flutter完整项目，WanAndroid客户端，BLoC、RxDart 、国际化、主题色、启动页、引导页',
            context),
            _repositoryItem('ZQ330093887/GankFlutter','https://github.com/ZQ330093887/GankFlutter',
            '干货集中营 客户端 flutter版',
            context),
            _repositoryItem('yangchong211/ycflutter','https://github.com/yangchong211/ycflutter',
            'flutter学习案例，接口使用玩Android开放的api，作为入门训练代码案例，耗时大概4个月【业余时间】，已经完成了基本的功能。努力打造一个体验好的flutter版本的玩android客户端！',
            context),
            _repositoryItem('MissYoung/Flutter_shop','https://github.com/MissYoung/Flutter_shop',
            '全网最全flutter 学习案例 仿闲鱼（开源版）',
            context),
            _repositoryItem('Sky24n/common_utils','https://github.com/Sky24n/common_utils',
            'Dart common utils library.Platforms: Flutter, web, other',
            context),
            _repositoryItem('Sky24n/flustars','https://github.com/Sky24n/flustars',
            'Flutter common utils library',
            context),

          ],
        ),
      ],
    );
  }
  Widget _repositoryItem(String title,String url,String desc,BuildContext context){
    return GestureDetector(
      onTap: (){
        Navigator.push(context, 
        MaterialPageRoute(
          builder: (context)=>WebPage(url, title)
        ));
      },
      child: Card(
          child:ListTile(
            leading: FlutterLogo(size:30.0),
            title:Padding(
              padding:EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
              child:Column(
                children: <Widget>[
                  Text(title,style:TextStyle(color:Colors.grey.shade900,fontWeight: FontWeight.bold)),
                  Text(desc,textAlign: TextAlign.center,),
                  Text.rich(
                    TextSpan(
                      text: url,
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      )
                    ),
                    maxLines: 1,
                    overflow:TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}