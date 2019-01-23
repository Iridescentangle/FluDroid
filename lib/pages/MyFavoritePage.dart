import 'package:flutter/material.dart';
import 'package:iridescentangle/utils/HttpUtil.dart';
import 'package:iridescentangle/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:iridescentangle/net/HttpService.dart';
class MyFavoritePage extends StatefulWidget {
  _MyFavoritePageState createState() => _MyFavoritePageState();
}

class _MyFavoritePageState extends State<MyFavoritePage> {
  List _favorite_list = List();
  bool hasData = false;
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
        if(data[Constants.DATAS].length == 0){
          setState(() {
                      hasData = false;
                    });
          
        }else{
          setState(() {
            hasData = true;
            _favorite_list.addAll(data[Constants.DATAS]); 
          });
        }
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
    if(hasData){
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
    }else{
      return Center(child:Text('您当前没有收藏文章哦!',style: TextStyle(color: Colors.grey,fontSize: 20.0),));
    }
  }
  Future<void> _onRefresh() async{

  }
  Widget _buildGridItem(BuildContext context,int index){
    var item = _favorite_list[index];
    return GestureDetector(
      onTap: (){

      },
      child: GridTile(
        child: Card(
          margin: EdgeInsets.all(10.0),
          // decoration: BoxDecoration(color: Colors.blue),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5.0),
                child: _buildImg(item['envelopePic']),
              ),
              _buildBottom(item['title'],item['author'],item['niceDate'],index,item['id'],item['originId']),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildPubDate(String pubDate){
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Text(pubDate,style: TextStyle(color: Colors.white),),
    );
  }
  Widget _buildAuthor(String author){
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
      child: Text(author,style: TextStyle(color: Colors.white),),
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
            duration: new Duration(
              seconds: 3,
            ),
            curve: Curves.elasticOut,  
      ),);
    }else{
      pic = Image.network(imgUrl,fit: BoxFit.cover,);
    }
     Widget container = Container(
        child: AspectRatio(
          aspectRatio: 2/3,
          child: pic,
        ),
    );
    return container;
  }
  Widget _buildBottom(String title,String author,String pubDate,int index,int id,int originId){
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width/2,
      decoration: BoxDecoration(color: Colors.grey.shade400),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(padding:EdgeInsets.all(5.0),child:Text(title,style: TextStyle(color: Colors.white,fontSize: 17.0,fontWeight: FontWeight.bold),),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                    _uncollect(index,id,originId);
                },
                child: Icon(
                  Icons.favorite,color:Colors.red,
                  size: 35.0,),
              ),
              
              Column(
                children: <Widget>[
                  _buildAuthor(author),
                  _buildPubDate(pubDate),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
  void _uncollect(int index,int id,int originId) async{
    String url = HttpService.WANANDROID_UNCOLLECT.replaceFirst('~', '$id');
    Map<String,String> map = Map<String,String>();
    map['originId'] = '$originId';
    HttpUtil.post(url, 
    (data){
      setState(() {
               _favorite_list.removeAt(index);
            });
     
    },
    params: map,
    errorCallback: (msg){
      print(msg);
    }
    );
  }
}