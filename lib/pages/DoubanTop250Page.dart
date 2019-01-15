import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iridescentangle/model/DouBanMovieTree.dart';
import 'dart:convert';
class DoubanTop250Page extends StatefulWidget {
  _DoubanTop250PageState createState() => _DoubanTop250PageState();
}

class _DoubanTop250PageState extends State<DoubanTop250Page> {
  int page = 0;
  int count = 24;
  List<MovieItem> list = List<MovieItem>();
  @override
  void initState() {
    super.initState();
    getData(page);
  }
  void getData(int page) async{
    var url = 'http://api.douban.com/v2/movie/top250?start=${page * 24}&count=${count}';
    await http.get(url).then((http.Response response){
      var tree = DouBanMovieTree.fromJson(json.decode(response.body));
      print(tree.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('豆瓣电影Top250'),
      ),
      body: _renderMovieGrid(context),
    );
  }
  Widget _renderMovieGrid(BuildContext context){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
              childAspectRatio: 0.7
            ),
      itemCount: 25,
      itemBuilder: _rendeMovieItem,
    );
  }
  Widget _rendeMovieItem(BuildContext context,int index){
    return Image.network('http://img1.doubanio.com/view/photo/s_ratio_poster/public/p1461851991.webp');
  }
}