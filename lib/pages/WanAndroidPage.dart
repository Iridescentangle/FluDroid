import 'package:flutter/material.dart';
import 'SearchPage.dart';
import 'package:flustars/src/screen_util.dart';
import 'LoginPage.dart';
class WanAndroidPage extends StatefulWidget {
  _WanAndroidPageState createState() => _WanAndroidPageState();
}

class _WanAndroidPageState extends State<WanAndroidPage> {
  double width;
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      
    }
  @override
  Widget build(BuildContext context) {
    width = ScreenUtil.getScreenW(context);
    return Scaffold(
       appBar: AppBar(title: Text("WanAndroid"),centerTitle: true,
       actions: <Widget>[
         IconButton(
           icon: Icon(Icons.search),
           onPressed: (){
             Navigator.of(context).push(
               MaterialPageRoute(
                 builder: (context)=>SearchPage()
               ),
             );
           },
         ),
        ],
       ),
       body: _renderBody(context),
    );
  }
  Widget _renderBody(BuildContext context){
    return ListView(
      children: <Widget>[
        _headPart(),
        _login(),
        _myFavorite(),
        _settings(),
        _about(),
        _logout(),
       
      ],
    );
  }
  Widget _headPart(){
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            width: width / 5,
            height: width / 5,
            child: CircleAvatar(
                backgroundImage: NetworkImage('https://avatar.csdn.net/F/B/8/3_qq_32319999.jpg'),
              ),
            ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 20.0),
            alignment: Alignment.center,
            child: Text('Iridescentangle',style: TextStyle(fontSize: 20.0,)),
          ),
        ],
      ),
    );
  }
  Widget _login(){
    return _buildListTile(
      Icon(Icons.person),
      Text('登录/注册'),
      (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context)=> LoginPage()
          ),
        );
      }
      );
  }
  Widget _myFavorite(){
    return _buildListTile(
      Icon(Icons.favorite_border), 
      Text('我的收藏'), 
      (){

      });
  }
  Widget _settings(){
    return _buildListTile(
      Icon(Icons.settings), 
      Text('设置中心'), 
      (){

      });
  }
  Widget _about(){
    return _buildListTile(
      Icon(Icons.info), 
      Text('更多信息'), 
      (){

      });
  }
  Widget _logout(){
    return _buildListTile(
      Icon(Icons.exit_to_app), 
      Text('退出登录'), 
      (){

      });
  }
  Widget _buildListTile(Icon icon,Text text,var onTap){
    return Card(
      margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      elevation: 3.0,
        child:ListTile(
          onTap: onTap,
          leading: icon,
          title: text,
          trailing: Icon(Icons.arrow_right),
        )
      );
  }
}