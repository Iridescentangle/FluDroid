import 'package:flutter/material.dart';
import 'SearchPage.dart';
import 'package:flustars/src/screen_util.dart';
import 'LoginPage.dart';
import 'dart:convert';
import 'package:iridescentangle/utils/UserUtil.dart';
import 'package:iridescentangle/utils/ToastUtil.dart';
import 'package:iridescentangle/utils/DialogUtil.dart';
import 'package:iridescentangle/net/HttpService.dart';
import 'package:dio/dio.dart';
import 'package:iridescentangle/utils/DioUtil.dart';
import 'package:iridescentangle/page_routes/FadePageRoute.dart';
import 'package:iridescentangle/utils/Constants.dart';
import 'MoreInfoPage.dart';
import 'MyFavoritePage.dart';
class WanAndroidPage extends StatefulWidget {
  _WanAndroidPageState createState() => _WanAndroidPageState();
}

class _WanAndroidPageState extends State<WanAndroidPage> {
  double width;
  String username = "";
  String avatarUrl = "";
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      initUserInfo();
    }
  void initUserInfo() async{
    await UserUtil.getUserName().then(
      (name){
        setState(() {
            if(name != null){
                    username = name;
            }else{
              username = '未登录状态';
            }
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
        UserUtil.isLogin().then(
          (isLogin){
            if(isLogin){
              ToastUtil.showToast('您已经登录!');
            }else{
               _navigatorToLogin(context);
            }
          }
        );
       
       
      }
      );
  }
  void _navigatorToLogin(BuildContext context) async{
    final data = await  Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context)=> LoginPage()
          ),
        );
    // if(data != null && data['errorCode']==0){
    //   setState(() {
    //           username = data['data']['username'];
    //           if(data['data']['icon'].length != 0){
    //             avatarUrl = data['data']['icon'];
    //           }
    //           favorite_list.clear();
    //           favorite_list.addAll(List.from(json.decode(data['data']['collectIds'].toString())));
    //         });
    // }
     if(data != null){
      setState(() {
              username = data['username'];
              if(data['icon'].length != 0){
                avatarUrl = data['icon'];
              }
            });
    }
  }
  Widget _myFavorite(){
    return _buildListTile(
      Icon(Icons.favorite_border), 
      Text('我的收藏'), 
      (){
        UserUtil.isLogin().then(
          (isLogin){
            if(isLogin){
              Navigator.push(context, 
                  FadePageRoute(MyFavoritePage())
                  );
            }else{
              ToastUtil.showToast('请先登录!');
            }
          }
        );
        
      });
  }
  Widget _settings(){
    return _buildListTile(
      Icon(Icons.settings), 
      Text('设置中心'), 
      (){
        ToastUtil.showToast('开发中,敬请期待!');
      });
  }
  Widget _about(){
    return _buildListTile(
      Icon(Icons.info), 
      Text('更多信息'), 
      (){
        Navigator.push(context, 
        FadePageRoute(MoreInfoPage())
        );
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
                 DioUtil.get(HttpService.WANANDROID_LOGOUT, 
                (Response response){
                  if(response.data[Constants.ERROR_CODE] == 0){
                    UserUtil.localLogOut();
                    setState(() {
                      username = '未登录状态';
                    });
                  }else{
                    ToastUtil.showToast('请再试一次!');
                  }
                 },errorCallBack: (String msg){
                   ToastUtil.showToast('网络错误,请再试一次!');
                 }
                );
                
                  
              }, "取消", (){
              });
            }else{
              ToastUtil.showToast("您尚未登录!");
            }
          }
        );
        
        
      });
  }

  Widget _buildListTile(Icon icon,Text text,Function onTap){
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