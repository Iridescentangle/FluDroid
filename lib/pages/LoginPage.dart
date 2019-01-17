import 'package:flutter/material.dart';
import 'package:flustars/src/screen_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:iridescentangle/net/HttpService.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = new TextEditingController(text: '');
  TextEditingController pwd = new TextEditingController(text: '');
  Dio dio;
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      dio = Dio();
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
      autofocus: false,
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
      autofocus: true,
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
    Map<String,Object> map = Map();
    map['username'] = userName;
    map['password'] = passWord+'';
    print(json.encode(map));
    // await dio.post(HttpService.WANANDROID_LOGIN,data:map).then(
    //   (Response response) async{
    //       print(response);
    //   }
    // );
    await http.post(HttpService.WANANDROID_LOGIN,body: map).then(
      (http.Response response){
          print(response.body);
      }
    );
    

  }

}