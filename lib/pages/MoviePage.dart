import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class MoviePage extends StatefulWidget {
  final Widget child;

  MoviePage({Key key, this.child}) : super(key: key);

  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  List<String> _swiper_data_list = [
            "https://img3.doubanio.com/view/photo/large/public/p1916528989.jpg?imageView2/2/q/80/w/1600/h/800/format/jpg",
            "https://img3.doubanio.com/view/photo/large/public/p1916530018.jpg?imageView2/2/q/80/w/1600/h/800/format/jpg",
            "https://img3.doubanio.com/view/photo/large/public/p1916531962.jpg?imageView2/2/q/80/w/1600/h/800/format/jpg",
            "https://img3.doubanio.com/view/photo/large/public/p2137343453.jpg?imageView2/2/q/80/w/1600/h/800/format/jpg",
            "https://img3.doubanio.com/view/photo/large/public/p2137343540.jpg?imageView2/2/q/80/w/1600/h/800/format/jpg"
        ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            actions: <Widget>[

            ],
            elevation: 3.0,
            primary: true,
            expandedHeight: 200.0,
            floating: false,//滑动折叠后继续滑动，是否隐藏标题等
            snap: false,
            pinned: true,
            flexibleSpace: Stack(
              children:<Widget>[
                Swiper(
                // pagination: new SwiperPagination(
                //     builder: DotSwiperPaginationBuilder(
                //   color: Colors.black54,
                //   activeColor: Colors.white,
                // )),
                itemBuilder: _swiperBuilder,
                itemCount: _swiper_data_list.length,
                // control: _swiperControl,
                scrollDirection: Axis.horizontal,
                autoplay: true,
                onTap: (index){
                    print('点击了第$index个');
                  }
                ),
                FlexibleSpaceBar(
                  title: new Text("这个杀手不太冷"),
                  centerTitle: true,
                  collapseMode: CollapseMode.pin,
                  
                ),
              ],
            ),
          ),
          new SliverFixedExtentList(
            itemExtent: 150.0,
            delegate:
                new SliverChildBuilderDelegate((context, index) => new ListTile(
                      title: new Text("List item $index"),
                    )),
          )
        ],
      ),
    );
  }
   Widget _swiperBuilder(BuildContext context,int index){
    return Image.network(_swiper_data_list[index],fit: BoxFit.cover,);
  }
  
}