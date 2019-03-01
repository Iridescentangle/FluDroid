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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
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
                    onPressed: _search,
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
    setState(() {
      _state =PageState.LOADING;
    });
    searchDoubanMovie(keyWord).then((data){
      if(data != null){
        setState(() {
         _resultDataList.addAll(data['subjects']); 
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
          itemCount: _resultDataList.length,
          itemBuilder: _buildResultItem,
        );
    }
  }
  Widget _buildResultItem(context,index){
    var item =_resultDataList[index];
    return Card(
              child: Container(
                alignment: Alignment.center,
                height: ScreenUtil.instance.setHeight(200),
                child:ListTile(
                  onTap: (){

                  },
                  leading: Container(
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
                          Text(item['title'],style: TextStyle(color: Colors.black,fontSize: ScreenUtil.instance.setSp(35),fontWeight: FontWeight.bold),),
                          RatingView(rating: item['rating']['average'],iconSize: ScreenUtil.instance.setWidth(25),fontSize: ScreenUtil.instance.setSp(22),),


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