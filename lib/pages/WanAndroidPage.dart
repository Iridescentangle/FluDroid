import 'package:flutter/material.dart';
import 'SearchPage.dart';
import 'package:flustars/src/screen_util.dart';
import 'LoginPage.dart';
import 'dart:convert';
import 'package:iridescentangle/utils/UserUtil.dart';
import 'package:iridescentangle/utils/ToastUtil.dart';
import 'package:iridescentangle/utils/DialogUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';
class WanAndroidPage extends StatefulWidget {
  _WanAndroidPageState createState() => _WanAndroidPageState();
}

class _WanAndroidPageState extends State<WanAndroidPage> {
  double width;
  String username = "";
  String avatarUrl = "";
  List<int> favorite_list = List();
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      initUserInfo();
    }
  void initUserInfo() async{
    UserUtil.localLogOut();
    await UserUtil.getUserName().then(
      (name){
        print('姓名:$name');
        setState(() {
                  username = name;
                });
      }
    );
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
    var avatar;
    if(avatarUrl == null || avatarUrl.length == 0){
      avatarUrl = "https://avatars1.githubusercontent.com/u/33859295?s=460&v=4";
    }
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
                backgroundImage: NetworkImage(avatarUrl),
              ),
            ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 20.0),
            alignment: Alignment.center,
            child: Text('${username}',style: TextStyle(fontSize: 20.0,)),
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
        _navigatorToLogin(context);
       
      }
      );
  }
  void _navigatorToLogin(BuildContext context) async{
    final data = await  Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context)=> LoginPage()
          ),
        );
    if(data != null && data['errorCode']==0){
      print(data['data']['password']);
      setState(() {
              initUserInfo();
              if(data['data']['icon'].length != 0){
                avatarUrl = data['data']['icon'];
              }
              favorite_list.clear();
              favorite_list.addAll(List.from(json.decode(data['data']['collectIds'].toString())));
            });
    }
  }
  Widget _myFavorite(){
    return _buildListTile(
      Icon(Icons.favorite_border), 
      Text('我的收藏(${favorite_list.length}条)'), 
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
  Widget _logout() {
    return _buildListTile(
      Icon(Icons.exit_to_app), 
      Text('退出登录'), 
      () async{
        UserUtil.isLogin().then(
          (isLogin){
            if(isLogin){
              DialogUtil.showAlertDialog(context, "退出登录", "您是否确认退出登录", "确定", (){
                setState(() {
                                  username = "蠢猪";
                                });
                // UserUtil.localLogOut().then(
                //   (suc){
                //       initUserInfo();
                //   }
                // );
              }, "取消", (){
              });
              
            }else{
              ToastUtil.showToast("您尚未登录!");
            }
          }
        );
        
        
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