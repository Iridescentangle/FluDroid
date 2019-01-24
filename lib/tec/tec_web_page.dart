import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:iridescentangle/utils/HttpUtil.dart';
import 'package:iridescentangle/net/HttpService.dart';
import 'package:iridescentangle/utils/ToastUtil.dart';
class TecWebDetailPage extends StatefulWidget {
  String url;
  String title;
  bool collected;
  int id = -1;
  TecWebDetailPage(this.url,this.title,{Key key,int this.id,this.collected}):super(key:key);
  _TecWebDetailPageState createState() => _TecWebDetailPageState();
}

class _TecWebDetailPageState extends State<TecWebDetailPage> {
  bool _collected = false;
  @override
  Widget build(BuildContext context) {
    var icon ;
    var iconChild;
    if(_collected){
      iconChild = Icon(Icons.favorite,color: Colors.red,size: 50.0,);
    }else{
      iconChild = Icon(Icons.favorite_border,color: Colors.red,size: 50.0,);
    }
    if(widget.id != -1){
      icon = GestureDetector(
        onTap: (){
          //收藏或者取消收藏该文章
          _collectOrUncollect(widget.id);
        },
        child: iconChild,
      );
    }else{
      icon = Container();
    }
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Stack(
        children: <Widget>[
           WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: icon,
          ),
        ],
    ),);
  }
  void _collectOrUncollect(int id) async{
    if(!_collected){
      HttpUtil.post(HttpService.WANANDROID_COLLECT.replaceAll('~', '${widget.id}'), 
      (data){
        ToastUtil.showToast('收藏成功!');
        setState(() {
                  _collected = true;
                });
      });
    }else{
      String url = 'http://www.wanandroid.com/lg/uncollect_originId/~/json'.replaceFirst('~', '${widget.id}');
      HttpUtil.post(url, 
        (data){
        ToastUtil.showToast('取消收藏成功!');
        setState(() {
                  _collected = false;
                });
        },
      errorCallback: (msg){
        ToastUtil.showToast(msg);
      }
      );
    }
  }
}
