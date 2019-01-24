import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/DoubanMovieDetail.dart';
import 'package:flustars/src/screen_util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../news/ArticleDetailPage.dart';
import 'package:fluwx/src/models/wechat_share_models.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
class MovieDetailPage extends StatefulWidget {
  String id;
  String title;
  MovieDetailPage({Key key,this.id,this.title}):super(key:key);
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  var width;
  List<String> _swiper_data_list = List<String>();
  SwiperControl _swiperControl = SwiperControl();
  double rating = 0.0;
  String pubdate = "-";
  String summary = "-";
  String duration = "-";
  String genres = "-";
  String directors = "-";
  String writers = "-";
  String casts = "-";
  List<Link> links = List<Link> ();
  @override
  void initState() {
    super.initState();
    fluwx.register(appId: "wx6df0d4e39075eb37");
    getMovieData();
  }
  void getMovieData() async{
    var url = "http://api.markapp.cn/v160/movies/${widget.id}/img_url/";
    await http.get(url).then((http.Response response){
        MovieTree tree = MovieTree.fromJson(json.decode(response.body));
        if(tree.status == 1){
          MovieData data = tree.data;
          setState(() {
            _swiper_data_list.clear();
            _swiper_data_list.addAll(data.photos);
            if(data.dbrating != null){
              rating = double.parse(data.dbrating);
            }
            pubdate = data.pubdate;
            summary = data.summary;
            duration =data.duration;
            genres = data.genres;
            directors = data.directors;
            writers = data.writers;
            casts = data.casts;
            links = data.links;
          });
        }
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    width = ScreenUtil.getScreenW(context); 
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: ((BuildContext context,bool innerBoxIsScrolled){
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverAppBar(
                expandedHeight: 170.0,
                flexibleSpace: _MoviePoster(),
                title: Text(widget.title),
                forceElevated: innerBoxIsScrolled,
              ),
            ),
          ];
        }),
        body:_renderBody(context),
        controller: ScrollController(),
        scrollDirection: Axis.vertical,
        reverse: false,
        physics: ScrollPhysics(),
        ),
      
    );
  }
  Widget _renderBody(BuildContext context){
    
    return Column(
      children: <Widget>[
        // _MoviePoster(),
        _renderStars(),
        Card(
          margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
          child:
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Text('概览',style:TextStyle(color:Colors.black)),
            ),
        ),
        Expanded(
          child:
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 8,
            itemBuilder: _renderOverViewItem,
          ),
        ),
      ],
    );
  }
  
  Widget _renderOverViewItem(BuildContext context,int index){
    switch(index){
      case 0:
        return _returnDifferentTile('上映', pubdate);
        break;
      case 1:
        return _returnDifferentTile('片长', duration);
        break;
      case 2:
        return _returnDifferentTile('类型', genres);
        break;
      case 3:
        return _returnDifferentTile('导演', directors);
        break;
      case 4:
        return _returnDifferentTile('编剧', writers);
        break;
      case 5:
        return _returnDifferentTile('主演', casts);
        break;
      case 6:
        return ListTile(
          title: Text(summary),
        );
        break;
      case 7:
          if(links.length == 0){
            return Center(child:CircularProgressIndicator());
          }else{
            Link link1 = links[0];
            Link link2 = links[1];
            var linkButton1 = _buildButton(link1.link, link1.name);
            var linkButton2 = _buildButton(link2.link, link2.name);
            var shareButton = Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                    child: Text('分享到微信'),
                  ),
            );
            return ListTile(
              leading: GestureDetector(
                onTap: (){
                  Future<dynamic> result = fluwx.share(WeChatShareWebPageModel(
                    title: widget.title,
                    thumbnail: _swiper_data_list[0],
                    description: '评分:$rating \n上映时间:$pubdate',
                    webPage: links[0].link,
                    transaction: "transaction}",
                    scene: fluwx.WeChatScene.SESSION,
                  ));
                },
                child: shareButton,
              ),
              title: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: linkButton1,
                  ),
                  Expanded(
                    flex: 1,
                    child: linkButton2,
                  ),
                ],
              ),
            );
          }
        break;
    }
  }
  Widget _buildButton(String link,String name){
    if(link != null){
       return GestureDetector(
            onTap: (){
              Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => ArticleDetailPage(url:link,title:name)
              )
              );
            },
            child: Center(
               child: Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                    child: Text(name),
                  ),
                ),
            ),
          );
    }else{
      return Container();
    }
  }
  Widget _returnDifferentTile(String title,String content){
    return ListTile(
        leading: Text(title,style: TextStyle(color: Colors.black45,fontSize: 17.0),),
        title: Text(
              content,
              softWrap: true,
              overflow: TextOverflow.clip,
              style: TextStyle(color: Colors.black87,fontSize: 17.0),
              ),
      );
  }
  Widget _renderStars(){
    return Container(
      width: ScreenUtil.getScreenW(context),
      height: 50.0,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text('豆瓣评分:',textAlign: TextAlign.center,),
          ),
          Expanded(
            flex: 1,
            child: 
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context,index){
                  double current_star = (index+1) * 2.0;
                  if(rating > current_star){
                    return Icon(Icons.star);
                  }else if(rating > current_star - 1.0){
                    return Icon(Icons.star_half);
                  }else{
                    return Icon(Icons.star_border);
                  }
                },
              ),
          ),
          
          Expanded(
            flex: 1,
            child: 
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child:Text('${rating}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:Colors.black,fontSize: 20.0),
                    ),
              ),
          ),
        ],
      ),
    );
  }
  Widget _MoviePoster(){
    if(_swiper_data_list.length == 0){
      return Container(width: 1.0,height: 1.0,);
    }
    return Container(
          width: MediaQuery.of(context).size.width,
          height: 200.0,
          child: Swiper(
             pagination: new SwiperPagination(
                builder: DotSwiperPaginationBuilder(
              color: Colors.black54,
              activeColor: Colors.white,
            )),
            itemBuilder: _swiperBuilder,
            itemCount: _swiper_data_list.length,
            // control: _swiperControl,
            scrollDirection: Axis.horizontal,
            autoplay: true,
            onTap: (index){
              print('点击了第$index个');
            }
          ),);
  }
  Widget _swiperBuilder(BuildContext context,int index){
    return Image.network(_swiper_data_list[index],fit: BoxFit.cover,);
  }
}