import 'package:flutter/material.dart';
import 'package:iridescentangle/utils/HttpUtil.dart';
import 'package:iridescentangle/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flustars/src/ui/my_app_bar.dart';
class MyFavoritePage extends StatefulWidget {
  _MyFavoritePageState createState() => _MyFavoritePageState();
}

class _MyFavoritePageState extends State<MyFavoritePage> {
  List _favorite_list = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  void getData(){
    HttpUtil.get('http://www.wanandroid.com/lg/collect/list/0/json', 
    (data){
      if(data != null){
        setState(() {
          _favorite_list.addAll(data[Constants.DATAS]); 
        });
      }
    },
    errorCallback: (msg){
      print(msg);
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的收藏'),centerTitle: true,),
      body: _renderBody(context),
    );
  }
  Widget _renderBody(BuildContext context){
    if(_favorite_list.length == 0){
      return Center(child: CircularProgressIndicator(),);
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: GridView.builder(
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                        mainAxisSpacing: 2.0,
                        crossAxisSpacing: 2.0,
                        childAspectRatio: 0.7
                      ),
        itemCount: _favorite_list.length,
        itemBuilder: _buildGridItem,
      ),
    );
  }
  Future<void> _onRefresh() async{

  }
  Widget _buildGridItem(BuildContext context,int index){
    var item = _favorite_list[index];
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildHead(item['title']),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            _buildImg(item['envelopePic']),
            Column(
              children: <Widget>[
                _buildAuthor(item['author']),
                // _buil
              ],
            ),
            
          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.favorite,color:Colors.red,
                size: 35.0,),
              Column(
                children: <Widget>[
                  _buildChapter(item['chapterName']),
                  _buildPubDate(item['niceDate']),
                ],
              ),
            ],
          ),

        ],
      )
    );
  }
  Widget _buildPubDate(String pubDate){
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Text(pubDate),
    );
  }
  Widget _buildChapter(String chapterName){
    return Container(
      decoration: BoxDecoration(
                            border: new Border.all(width: 1.0, color: Colors.grey,),
                            borderRadius: new BorderRadius.all(new Radius.circular(3.0)),
                            color: Colors.white,
                        ),
                        child:  Padding(
                          padding: EdgeInsets.all(3.0),
                          child:Text(chapterName),)
    );
    
  }
  Widget _buildAuthor(String author){
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
      child: Text(author),
    );
  }
  Widget _buildImg(String imgUrl){
    Widget pic;
   
    if(imgUrl == null || imgUrl.length == 0){
      pic = Center(child: FlutterLogo(
           size: 60.0,
            colors: Colors.lightBlue, // 图的颜色
            textColor: Colors.orange, // 只对带文字的style起作用
            style: FlutterLogoStyle.markOnly,  // 只有图
            // style: style, // 左图右文
            // style: FlutterLogoStyle.stacked,  // 上图下文
            duration: new Duration(
              // 当colors、textColor或者style变化的时候起作用
              seconds: 3,
            ),
            curve: Curves.elasticOut,  
      ),);
    }else{
      pic = Image.network(imgUrl);
    }
     Widget container = Container(
       decoration: BoxDecoration(color: Colors.grey.shade200),
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width /3,
      child: AspectRatio(
        aspectRatio: 0.75,
        child: pic,
      )
    );
    return container;
  }
  Widget _buildHead(String title){
    return Padding(
      padding: EdgeInsets.all(5.0),
      child:Text(title,style: TextStyle(color: Colors.black,fontSize: 17.0,fontWeight: FontWeight.bold),),
    );
  }
}