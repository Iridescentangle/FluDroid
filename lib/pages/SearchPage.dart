import 'package:flutter/material.dart';
import 'package:iridescentangle/utils/DioUtil.dart';
import 'package:iridescentangle/net/HttpService.dart';
import 'SearchResultPage.dart';
import 'package:iridescentangle/utils/ToastUtil.dart';
import 'package:iridescentangle/utils/NavigatorUtil.dart';
class SearchPage extends StatefulWidget {
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List _hotKeyList = List ();
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHotKeyWords();
  }
  void getHotKeyWords() async{
    DioUtil.get(HttpService.WANANDROID_HOT_KEY, (data){
      setState(() {
       _hotKeyList.addAll(data); 
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: TextField(
          controller: _controller,
          textCapitalization: TextCapitalization.words,
          autofocus: true,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: '请输入您要搜索的内容',
            fillColor: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear,),
            onPressed: (){
              _controller.clear();
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              _search();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _getHotKeyChips(),
        ],
      ),
    );
  }
  void _search(){
    String searchText = _controller.text;
    if(searchText.length == 0){
     ToastUtil.showToast('请输入要搜索的内容!');
     return;
    }
    NavigatorUtil.navigateWithFade(context, SearchResultPage(name:searchText));
  }
  Widget _getHotKeyChips(){
    return Column(
      children:<Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            alignment: Alignment.centerLeft,
            child: Text('热搜:',style: TextStyle(color: Colors.black,fontSize: 18.0),textAlign: TextAlign.start,),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: _hotKeyList.map(
              (item){
                return Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.fromLTRB(5.0,0.0,5.0,0.0),
                  child:ActionChip(
                    onPressed: (){
                      Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context)=>SearchResultPage(name:item['name'])
                      )
                      );
                    },
                    label: Text(item['name'],style: TextStyle(color: Colors.white),),
                    backgroundColor: Colors.lightBlue,
                  ),
                );
              }
            ).toList(),
          ),
      ]
    );
  }
}