import 'package:flutter/material.dart';
class DoubanTop250Page extends StatefulWidget {
  _DoubanTop250PageState createState() => _DoubanTop250PageState();
}

class _DoubanTop250PageState extends State<DoubanTop250Page> {
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