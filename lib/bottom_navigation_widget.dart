import 'package:flutter/material.dart';
import 'news/news_page.dart';
import 'weather/weather_page.dart';
import 'tec/tec_page.dart';
class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}
class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _bottom_navigation_color = Colors.lightBlue;
  int current_index = 0;
  @override
    void initState() {
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Iridescentangle'),),
      appBar: AppBar(title: Container(decoration: BoxDecoration(color: Colors.blue),),),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: current_index,
      items: [
        BottomNavigationBarItem(
          title: Text('新闻',style: TextStyle(color: _bottom_navigation_color),),
          icon: Icon(Icons.book,color: _bottom_navigation_color,),
        ),
        BottomNavigationBarItem(
          title: Text('天气',style: TextStyle(color: _bottom_navigation_color),),
          icon: Icon(Icons.wb_sunny,color: _bottom_navigation_color,),
        ),
        BottomNavigationBarItem(
          title: Text('技术',style: TextStyle(color: _bottom_navigation_color),),
          icon: Icon(Icons.build,color: _bottom_navigation_color,),
        ),
      ],
      type: BottomNavigationBarType.shifting,
      onTap: (int index){
        setState(() {
                  current_index = index;
                });
      },
    ),
      body: IndexedStack(
        children: <Widget>[
          NewsPage(),
          WeatherPage(),
          TecPage(),
        ],
        index: current_index,
      ),
    );
  }
}