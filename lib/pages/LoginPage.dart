import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:iridescentangle/utils/ToastUtil.dart';
import 'package:iridescentangle/utils/UserUtil.dart';
import 'package:iridescentangle/utils/HttpUtil.dart';
import 'package:iridescentangle/page_routes/FadePageRoute.dart';
import 'RegisterPage.dart';
class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = new TextEditingController(text: '');
  TextEditingController pwd = new TextEditingController(text: '');
  Dio dio;
  @override
    void initState() {
      super.initState();
      dio = Dio();
    }
  @override
    void dispose() {
      // TODO: implement dispose
      username.dispose();
      pwd.dispose();
      super.dispose();
      
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录/注册'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          _circleHead(),
          _nameInput(),
          _passwordInput(),
          _login(),
          _register(),
        ],
      ),
    );
  }
  Widget _circleHead(){
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width /3 ,
      child: new Icon(
          Icons.account_circle,
          color: Colors.lightBlue,
          size: MediaQuery.of(context).size.width / 4,
        ),
    );
  }
  Widget _nameInput(){
    var nameInput = TextField(
      controller: username,
      autofocus: true,
      cursorColor: Colors.lightBlue,
      decoration: InputDecoration(
        labelText: '请输入用户名',
        fillColor: Colors.lightBlue,
      ),
    );
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(width/ 4, 5.0, width / 4, 5.0),
      child: Padding(
        padding:EdgeInsets.all(10.0),
        child:nameInput,)
    );
  }
  Widget _passwordInput(){
     var nameInput = TextField(
      controller: pwd,
      obscureText: true,
      cursorColor: Colors.lightBlue,
      decoration: InputDecoration(
        labelText: '请输入密码',
        fillColor: Colors.lightBlue,
      ),
    );
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(width/ 4, 5.0, width / 4, 5.0),
      child: Padding(
        padding:EdgeInsets.all(10.0),
        child:nameInput,)
    );
  }
  Widget _login(){
    var width = MediaQuery.of(context).size.width;
    var loginButton = RaisedButton(
        onPressed: (){
          _toLogin();
        },
        textColor: Colors.white,
        color: Colors.blue,
        disabledColor: Colors.grey,
        elevation: 4.0,
        child: Text('登录',style: TextStyle(fontSize: 20.0),),

      );
    return Container(
      margin: EdgeInsets.fromLTRB(width / 4+5.0, 30.0, width/4+5.0, 5.0),
      height: width / 8,
      child: loginButton,
    );
  }
  Widget _register(){
    var width = MediaQuery.of(context).size.width;
    var registerButton = RaisedButton(
        onPressed: (){
          _navigateToRegister();
        },
        textColor: Colors.white,
        color: Colors.blue,
        disabledColor: Colors.grey,
        elevation: 4.0,
        child: Text('注册',style: TextStyle(fontSize: 20.0),),

      );
    return Container(
      margin: EdgeInsets.fromLTRB(width / 4+5.0, 30.0, width/4+5.0, 5.0),
      height: width / 8,
      child: registerButton,
    );
  }
  void _navigateToRegister() async{
    String name = username.text;
    if(name != null){
      var result = await Navigator.push(context, 
      FadePageRoute(RegisterPage(name:name))
      );
      if(result == 1){
        //说明是自动登录成功了
        Navigator.pop(context,1);
      }
    }
  }
  void _toLogin() async{
    String userName = username.text;
    String passWord = pwd.text;
    if(userName.length == 0){
      Fluttertoast.showToast(msg:'请检查用户名!');
      return;
    }
    if(passWord.length == 0){
      Fluttertoast.showToast(msg:'请检查密码!');
      return;
    }
    Map<String,String> map = Map();
    map['username'] = userName;
    map['password'] = passWord;
    HttpUtil.post("user/login",(var data){
      if(data != null){
        // print(data);
        //说明登录成功了返回了用户数据
        // UserUtil.saveInfo(data['data']['username']);
        UserUtil.saveInfo(data['username']);
        Navigator.pop(context,data);
      }
    },params:map,errorCallback: (String errorMsg){
      ToastUtil.showToast(errorMsg);
    }
    );
  }

}