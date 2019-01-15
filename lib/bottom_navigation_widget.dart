import 'package:flutter/material.dart';
import 'news/news_page.dart';
import 'weather/weather_page.dart';
import 'tec/tec_page.dart';
import 'tool/ToolPage.dart';
class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}
const List<String> _pageNames = <String>[
  '新闻','天气','技术','工具'
];
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
      appBar: AppBar(elevation:0.0,title: Center(child:Text(_pageNames[current_index]),)),
      // appBar: AppBar(title: Container(decoration: BoxDecoration(color: Colors.blue),),),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: current_index,
      items: [
        BottomNavigationBarItem(
          title: Text('${_pageNames[0]}',),
          icon: Icon(Icons.book,),
        ),
        BottomNavigationBarItem(
          title: Text(_pageNames[1],),
          icon: Icon(Icons.wb_sunny,),
        ),
        BottomNavigationBarItem(
          title: Text(_pageNames[2],),
          icon: Icon(Icons.build,),
        ),
        BottomNavigationBarItem(
          title: Text(_pageNames[3],),
          icon: Icon(Icons.add_box,),
        ),
      ],
      type: BottomNavigationBarType.fixed,
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
          ToolPage(),
        ],
        index: current_index,
      ),
    );
  }
}