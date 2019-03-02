import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';
import '../utils/ToastUtil.dart';
import '../net/ServiceMethods.dart';
import 'package:flutter/cupertino.dart';
import '../widget/SearchEmptyView.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widget/RatingView.dart';
import '../utils/NavigatorUtil.dart';
import '../pages/MovieDetailPage.dart';
class DoubanSearchPage extends StatefulWidget {
  _DoubanSearchPageState createState() => _DoubanSearchPageState();
}

class _DoubanSearchPageState extends State<DoubanSearchPage> {
  List _resultDataList = [];
  TextEditingController controller =TextEditingController();
  TextEditingController _textController =TextEditingController();
  TextField textField;
  String keyWord = '';
  PageState _state =PageState.EMPTY;
  int page = 0;
  ScrollController _scrollController =ScrollController();
  bool _loadedAll = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        //说明滑动到底部了
        page += 1;
        _search();
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    textField = TextField(
                  style: TextStyle(color: Colors.white,fontSize: ScreenUtil.instance.setSp(33)),
                  decoration: InputDecoration(
                  hintText: '请输入要搜索的电影名',hintStyle: TextStyle(color: Colors.white),fillColor: Colors.white,border: InputBorder.none,),
                  maxLines: 1,
                  cursorColor: Colors.white,
                  controller: _textController,
                  );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
       appBar: PreferredSize(
        child: AppBar(
                title: textField,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: (){
                      setState(() {
                        _textController.clear();
                        _state =PageState.EMPTY;
                        _resultDataList.clear();
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: (){
                      page = 0;
                      _resultDataList.clear();
                      _search();
                    }
                  ),
                ],
              ),
        preferredSize: Size.fromHeight(55.0)),
      body: _body(context),
        
    );
  }
  void _search() async{
    String keyWord =_textController.text;
    if(keyWord.isEmpty){
      return ToastUtil.showToast('请输入您要搜索的内容!');
    }
    if(page == 0){
      setState(() {
        _state =PageState.LOADING;
      });
    }
    searchDoubanMovie(keyWord,page * 20).then((data){
      if(data != null){
        setState(() {
          if((data['subjects'] as List).cast().length > 0){
            _loadedAll = false;
            _resultDataList.addAll(data['subjects']); 
          }else{
            _loadedAll = true;
          }
         _state =PageState.RESULT;
        });
      }
    });
  }
  Widget _body(context){
    switch(this._state){
      case PageState.EMPTY:
        return Center(
          child: Text('豆瓣电影',style:Theme.of(context).textTheme.display1),
        );
      case PageState.LOADING:
        return Center(
          child: CupertinoActivityIndicator(),
        );
      case PageState.NORESULT:
        return SearchEmptyView();
      case PageState.RESULT:
        return ListView.builder(
          controller: _scrollController,
          itemCount: _resultDataList.length+1,//因为有一条是底部"加载更多"
          itemBuilder: _buildResultItem,
        );
    }
  }
  Widget _buildResultItem(context,index){
    if(index ==_resultDataList.length){
      return Container(
        height: ScreenUtil.instance.setHeight(70),
        alignment: Alignment.center,
        child: Text(_loadedAll?'我也是有底线的!':'加载更多中... ...',style: TextStyle(color: Colors.grey),),
      );
    }
    var item =_resultDataList[index];
    return Card(
              child: Container(
                alignment: Alignment.center,
                height: ScreenUtil.instance.setHeight(200),
                child:ListTile(
                  onTap: (){
                    NavigatorUtil.navigateWithFade(context, MovieDetailPage(title: item['title'],id: item['id'],),);
                  },
                  leading: Container(
                    alignment: Alignment.center,
                    width: ScreenUtil.instance.setWidth(140),
                    height: ScreenUtil.instance.setHeight(180),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(ScreenUtil.instance.setWidth(20)),
                      child:Image.network(item['images']['medium'],fit: BoxFit.cover,),
                    )
                  ),
                  title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:EdgeInsets.fromLTRB(0.0,ScreenUtil.instance.setWidth(15),0.0,ScreenUtil.instance.setHeight(15)),
                            child:Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  color: Colors.black,fontSize: ScreenUtil.instance.setSp(31),fontWeight: FontWeight.bold,
                                ),
                                children:[
                                  TextSpan(
                                    text:item['title'],
                                  ),
                                  TextSpan(
                                    text: '(${item['original_title']})',
                                    style: TextStyle(color: Colors.grey.shade400,fontSize: ScreenUtil.instance.setSp(20),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          RatingView(rating: item['rating']['average'],iconSize: ScreenUtil.instance.setWidth(25),fontSize: ScreenUtil.instance.setSp(22),),
                          Text(item['directors']== null || item['directors'].length == 0?'导演: 暂无详细信息':'导演: ${item['directors'][0]['name']}',style: TextStyle(fontSize: ScreenUtil.instance.setSp(23)),)

                        ],
                    ),
                ),
              ),
            );
  }

}
enum PageState{
  EMPTY,LOADING,RESULT,NORESULT,
}