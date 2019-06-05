import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:ui';
import 'tec_web_page.dart';
import 'package:iridescentangle/utils/DioUtil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:flukit/src/swiper.dart';
import 'package:iridescentangle/net/HttpService.dart';
import 'package:iridescentangle/page_routes/FadePageRoute.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
class TecPage extends StatefulWidget {
  _TecPageState createState() => _TecPageState();
}

class _TecPageState extends State<TecPage> with SingleTickerProviderStateMixin{
  @override
  bool get wantKeepAlive => true;
  List<Object> _body_list;
  List _swiper_data_list = List();
  // SwiperControl _swiperControl = SwiperControl();
  int page = 0;
  var topUrl = "http://www.wanandroid.com/article/top/json";
  var pageUrl ;
  ScrollController _scrollController = ScrollController(); //listview的控制器
  bool isLoading = false; //是否正在加载数据
  @override
  void initState() {
    super.initState();
    _body_list = List();
    pageUrl = "http://www.wanandroid.com/article/list/${page}/json";
    loadData(page);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
  }
  /**
   * 上拉加载更多
   */
  Future _getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      page += 1;
      pageUrl = "http://www.wanandroid.com/article/list/${page}/json";
      Dio().get(pageUrl).then( (result){
        print(result.toString());
        print(result.runtimeType);
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            var data = json.decode(result.toString());
            _body_list.addAll(data['datas']);
            isLoading = false;
          });
        });
      });

    }
  }
  void loadData(int page) async{
    Dio().get(topUrl).then((result){
      var data = json.decode(result.toString());
      setState(() {
        _body_list.addAll(data['data']);
      });
    });
    Dio().get(pageUrl).then((result){
      setState(() {
        var data = json.decode(result.toString());
        _body_list.addAll(data['data']['datas']);
      });
    });
    Dio().get(HttpService.WANANDROID_BANNER).then((result){
      var data = json.decode(result.toString());
      _swiper_data_list.addAll(data['data']);
    });

  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(_body_list == null || _body_list.length == 0){
      return Center(child: CupertinoActivityIndicator(),);
    }else{
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child:ListView.builder(
          itemBuilder: _renderTile,
          itemCount: _body_list.length+2,
          controller: _scrollController,
        ),
      );
    }
  }
  /**
   * 下拉刷新方法,为list重新赋值
   */
  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _body_list.clear();
      });
      page = 0;
      loadData(page);
    });
  }
  Widget _renderTile(BuildContext context,int index){
    if(index == 0){
      if(_swiper_data_list == null || _swiper_data_list.length == 0){
        return Container();
      }else{
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 200.0,
          child: Swiper(
            //  pagination: new SwiperPagination(
            //     builder: FractionPaginationBuilder(
            //       activeFontSize: 20.0,
            //       fontSize: 20.0,
            //   color: Colors.black54,
            //   activeColor: Colors.white,
            // )),
              itemBuilder: _swiperBuilder,
              itemCount: _swiper_data_list.length,
              // control: _swiperControl,
              scrollDirection: Axis.horizontal,
              autoplay: true,
              onTap: (index){
                Navigator.push(context,
                    FadePageRoute(TecWebDetailPage(_swiper_data_list[index]['url'],_swiper_data_list[index]['title'],))
                );
              }
          ),);
      }
    }
    if (index >= _body_list.length+1) {
      return _getMoreWidget();
    }
    Map<String, dynamic> item = _body_list[index-1];
    var fresh;
    var collect;
    var envolope;
    if(index < 3){
      fresh =  Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: new Border.all(width: 1.0, color: Colors.red,),
          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(3.0),
          child:
          Text('置顶') ,
        ),
      );
    }else{
      fresh = Container(
        margin: EdgeInsets.all(10.0),
        width: 40.0,height: 0.0,);
    }
    if(item['collect']){
      collect = Icon(Icons.favorite,color: Colors.pink,);
    }else{
      collect = Icon(Icons.favorite_border,color: Colors.pink,);
    }
    if(item['envelopePic'] == ""){
      envolope = null;
    }else{
      envolope = Image.network(item['envelopePic']);
    }
    return ListTile(
      onTap:(){
        Navigator.push(
            context,MaterialPageRoute(
            builder: (context) => TecWebDetailPage(item['link'],item['title'],id:item['id'],collected:item['collect'])
        )
        );
      },
      title: Card(
        color: Colors.white,
        elevation: 4.0,
        child: Container(
          width: 540.0,
          height: 110.0,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      fresh,
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                        child: Text('${item['author']}'),
                      ),
                    ],
                  ),

                ],
              ),
              Positioned(
                left: 10.0,
                top: 40.0,
                bottom: 10.0,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Text('${item['title']}',style: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight:FontWeight.bold),),
                ),
              ),
              Positioned(
                right: 0.0,
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  child: Text('${item['niceDate']}',style: TextStyle(color: Colors.grey),),
                ),
              ),
              Positioned(
                  bottom: 5.0,
                  left: 10.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                        child: Text('${item['superChapterName']}/'),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                        child: Text('${item['chapterName']}'),
                      ),

                    ],
                  )
              ),
              Positioned(
                right: 5.0,
                bottom: 5.0,
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  child: collect,
                ),
              ),
              Positioned(
                right: 10.0,
                top: 40.0,
                child: Container(
                  width: 40.0,
                  height: 30.0,
                  child: envolope,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /**
   * 加载更多时显示的组件,给用户提示
   */
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...     ',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(strokeWidth: 1.0,)
          ],
        ),
      ),
    );
  }
  Widget _swiperBuilder(BuildContext context,int index){
    return Image.network(_swiper_data_list[index]['imagePath'],fit: BoxFit.cover,);
  }

}