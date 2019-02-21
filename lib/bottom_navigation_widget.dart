import 'package:flutter/material.dart';
import 'news/news_page.dart';
import 'tec/tec_page.dart';
import 'tool/ToolPage.dart';
import 'package:iridescentangle/pages/WanAndroidPage.dart';
class BottomNavigationWidget extends StatefulWidget {
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}
const List<String> _pageNames = <String>[
  '新闻','技术','工具','WanAndroid'
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
    var appBar;
    if(current_index == 3){
      appBar = null;
    }else{
      appBar = AppBar(elevation:2.0,title: Center(child:Text(_pageNames[current_index]),));
    }
    return Scaffold(
      appBar: appBar,
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
          icon: Icon(Icons.build,),
        ),
        BottomNavigationBarItem(
          title: Text(_pageNames[2],),
          icon: Icon(Icons.pan_tool,),
        ),
        BottomNavigationBarItem(
          title: Text(_pageNames[3],),
          icon: Icon(Icons.android,),
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
          TecPage(),
          ToolPage(),
          WanAndroidPage(),
        ],
        index: current_index,
      ),
    );
  }
}