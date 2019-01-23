import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
class TecWebDetailPage extends StatelessWidget {
  final String url;
  final String title;
  int id = -1;

  TecWebDetailPage(this.url, this.title,{int this.id});

  @override
  Widget build(BuildContext context) {
    // return new WebviewScaffold(
    //   withJavascript: true,
    //   url: url,
    //   scrollBar:true,
    //   withLocalUrl: true,
    //   appBar: new AppBar(
    //     title: Text(title),
    //   ),
    // );
    var icon ;
    if(id != -1){
      icon = GestureDetector(
        onTap: (){

        },
        child: Icon(Icons.favorite_border,size: 30.0,),
      );
    }else{
      icon = Container();
    }
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Stack(
        children: <Widget>[
           WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: icon,
          ),
        ],
    ),);
  }
}
