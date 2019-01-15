import 'package:flutter/material.dart';
import 'package:sky_engine/_http/http.dart';
import 'package:flutter/cupertino.dart';
import 'article_page.dart';
class NewsPage extends StatefulWidget {
  _NewsPageState createState() => _NewsPageState();
}
const List<String> _allNames = <String>[
  '头条',
  '社会',
  '国内',
  '国际',
  '娱乐',
  '体育',
  '军事',
  '科技',
  '财经',
  '时尚'
];
const List<String> _allTypes = <String> [
  'top',
  'shehui',
  'guonei',
  'guoji',
  'yule',
  'tiyu',
  'junshi',
  'keji',
  'caijing',
  'shishang',
];
class _NewsPageState extends State<NewsPage> with SingleTickerProviderStateMixin{
  TabController _controller ;
  List _articleList;
  bool _customIndicator = false;
  @override
    void initState() {
      super.initState();
      _controller =  TabController(vsync: this,length: _allNames.length);
    }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: TabBar(
            controller: _controller,
            isScrollable: true,
            tabs: _allNames.map<Tab>((String tag){
                return Tab(text:tag);
             }
            ).toList(),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: _allTypes.map((String tab){
              return ArticlePage(type:tab,name:_allNames[_allTypes.indexOf(tab)]);
            }
          ).toList(),
        ),
      );
    }
}