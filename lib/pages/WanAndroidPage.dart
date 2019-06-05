import 'package:flutter/material.dart';
import 'SearchPage.dart';
import 'package:flustars/src/screen_util.dart';
import 'LoginPage.dart';
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
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
class WanAndroidPage extends StatefulWidget {
  _WanAndroidPageState createState() => _WanAndroidPageState();
}

class _WanAndroidPageState extends State<WanAndroidPage> {
  double width;
  String username = "";
  String avatarUrl = "";
  bool _isLogin = false;
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
              _isLogin = true;
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
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Text("WanAndroid"),centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              if(_isLogin){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context)=>SearchPage()
                  ),
                );
              }else{
                ToastUtil.showToast('您尚未登录!');
              }
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
  Widget _clipPath(color,height){
    return ClipPath(
      clipper: AvatarBackGroungClipper(),
      child: Container(
        color: color,
        height: height,
      ),
    );
  }
  Widget _headPart(){
    
    var avatar;
    if(avatarUrl == null || avatarUrl.length == 0){
      // avatarUrl = "https://avatars1.githubusercontent.com/u/33859295?s=460&v=4";
      avatar = Image.asset('assets/images/wanandroid_avatar.png',);
    }else{
      avatar = CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
              );
    }
    return Container(
      height: 200.0,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          _clipPath(Colors.lightBlueAccent,200.0),
          _clipPath(Colors.lightBlue,160.0),
          _clipPath(Colors.blue, 120.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                width: width / 5,
                height: width / 5,
                child: avatar,
                ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 20.0),
                alignment: Alignment.center,
                child: Text('${username}',style: TextStyle(fontSize: 20.0,color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
    // return Card(
    //   margin: EdgeInsets.all(10.0),
    //   elevation: 4.0,
    //   child: 
    // );
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
    final result = await  Navigator.of(context).push(
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
    if(result == 1){
      //说明是注册成功了自动登录的界面
      _isLogin = true; 
      initUserInfo();
      return;
    }
     if(result != null){
      setState(() {
              _isLogin = true;
              username = result['username'];
              if(result['icon']!= null && result['icon'].length != 0){
                avatarUrl = result['icon'];
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
        // Navigator.push(context, 
        // MaterialPageRoute(
        //   builder: (context)=>PickImgPage()
        // ));
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
                      _isLogin = false;
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
class AvatarBackGroungClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0,0);
    path.lineTo(0, size.height-50);
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width , size.height - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, size.height -50);
    path.lineTo(size.width, 0.0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}