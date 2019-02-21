import 'package:flutter/material.dart';
import 'package:iridescentangle/utils/HttpUtil.dart';
import 'package:iridescentangle/net/HttpService.dart';
import 'package:flutter/cupertino.dart';
class SearchResultPage extends StatefulWidget {
  String name;
  SearchResultPage({Key key,this.name}):super(key:key);
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  String url = HttpService.WANANDROID_SEARCH;
  List data = List();
  bool _noResult = true;
  @override
  void initState() {
    super.initState();
    _search();
  }
  void _search() async {
    Map<String,String> map =Map();
    map['k'] =widget.name;
    HttpUtil.post(url.replaceAll('~', '0'),(data){
      List datas = data['datas'];
      if(datas != null && datas.length > 0){
        setState(() {
          _noResult = false;
          this.data.clear();
          this.data.addAll(datas);
        });
      };
    },params: map,
    errorCallback:(e){
      print(e);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name),centerTitle: true,),
      body: _renderBody(),
    );
  }
  Widget _renderBody(){
    if (_noResult) {
      return SearchEmptyView();
    }else{
      return ListView(
        children: 
        data.map((item){
          String pureTitle = item['title'].toString().replaceAll('<em class=\'highlight\'>', '').replaceAll('</em>', '');
          return GestureDetector(
            onTap: (){},
            child:Card(
              elevation: 1.0,
              child: Container(
                // child: ,
              ),
            ),
          );
          // return Container(
          //   child: Text('${item['author']}:${pureTitle}',style: TextStyle(color: Colors.black,fontSize: 20.0),overflow: TextOverflow.ellipsis,),
          // );
        }
        ).toList(),
      );
    }
    return Container();
  }
  // Widget buildItem(){
  //   Container(
  //     height: 56.0,
  //     margin: EdgeInsets.only(top: 0.0),
  //     child: new ListTile(
  //         onTap: (){},
  //         title: new Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             new Icon(
  //               leftIcon ?? Icons.whatshot,
  //               color: titleColor ?? Colors.blueAccent,
  //             ),
  //             Gaps.hGap10,
  //             new Expanded(
  //                 child: new Text(
  //               title ?? IntlUtil.getString(context, titleId),
  //               overflow: TextOverflow.ellipsis,
  //               style: TextStyle(
  //                   color: titleColor ?? Colors.blueAccent,
  //                   fontSize: Utils.getTitleFontSize(
  //                       title ?? IntlUtil.getString(context, titleId))),
  //             ))
  //           ],
  //         ),
  //         trailing: new Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             new Text(
  //               extra ?? IntlUtil.getString(context, extraId),
  //               style: TextStyle(color: Colors.grey, fontSize: 14),
  //             ),
  //             new Icon(
  //               rightIcon ?? Icons.keyboard_arrow_right,
  //               color: Colors.grey,
  //             ),
  //           ],
  //         )),
  //     decoration: new BoxDecoration(
  //         //new Border.all(width: 0.33, color: Colours.divider)
  //         border: new Border(
  //             bottom: new BorderSide(width: 0.33, color: Colours.divider))),
  //   );
  // }
}
class SearchEmptyView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 130.0,
              height: 100.0,
              child: Image.asset('assets/images/no_data.png',),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('没有搜索到结果，换个词试试?',style:Theme.of(context).textTheme.subhead),
            ),
          ],
        ),
      );
  }
}