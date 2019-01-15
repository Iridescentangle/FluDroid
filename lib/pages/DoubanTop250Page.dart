import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iridescentangle/model/DouBanMovieTree.dart';
import 'dart:convert';
import 'package:flustars/src/screen_util.dart';
class DoubanTop250Page extends StatefulWidget {
  _DoubanTop250PageState createState() => _DoubanTop250PageState();
}

class _DoubanTop250PageState extends State<DoubanTop250Page> {
  int page = 0;
  int count = 24;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();
  List<MovieItem> list = List<MovieItem>();
  @override
  void initState() {
    super.initState();
    getData(page);
    _scrollController.addListener((){
      if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _getMore();
        }
    });
  }
  
  void getData(int page) async{
    var url = 'http://api.douban.com/v2/movie/top250?start=${page * 24}&count=${count}';
    await http.get(url).then((http.Response response){
      DouBanMovieTree tree = DouBanMovieTree.fromJson(json.decode(response.body));
        setState(() {
                  list.addAll(tree.subjects);
                });
    });
  }
  @override
  Widget build(BuildContext context) {
    var body;
    if(list.length == 0){
      body = Center(child:CircularProgressIndicator());
    }else{
      body = _renderMovieGrid(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('豆瓣电影Top250'),
      ),
      body: body,
    );
  }
  Widget _renderMovieGrid(BuildContext context){
    Widget grid = RefreshIndicator(
          onRefresh: _onRefresh,
          child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 2.0,
                        childAspectRatio: 0.7
                      ),
                itemCount: list.length + 3,
                itemBuilder: _rendeMovieItem,
              ),
         );
    return grid;
  }
  Future<Null> _onRefresh() async{
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
              list.clear();
            });
      page = 0;
      getData(page);
    });
  }
  Widget _rendeMovieItem(BuildContext context,int index){
    MovieItem item;
    if(index <= list.length-1){
      item = list[index];
    }
    if(index >= list.length){
      //说明是底部的条目
      if(list.length == 250){
        return Center(child: Text('我也是有底线的!'),);
      }
      return Center(child: Text('加载更多...'),);
    }
    return Card(
      margin: EdgeInsets.all(5.0),
      elevation: 4.0,
      child: Container(
        margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 0.0),
          child:Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 0.75,  //    ratio = 宽 / 高 ,
                child: Image.network(item.images.medium,fit: BoxFit.scaleDown,),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 3.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.white),
                child: Text( item.title,
                  textAlign:TextAlign.center,
                  overflow:TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 12.0,),),
              ),
            ],
          ),
      ),
    );
  }
  void _getMore() async{
    if(!isLoading){
      setState(() {
              isLoading = true;
            });
    }
     page += 1;
     var url = "http://api.douban.com/v2/movie/top250?start=${page * 24}&count=${count}";
      http.Response response = await http.get(url);
      DouBanMovieTree result = DouBanMovieTree.fromJson(json.decode(response.body));
      await Future.delayed(Duration(seconds: 1),(){
          setState(() {
                      list.addAll(result.subjects);
                      isLoading = false;
                    });
        }
      );
  }
}