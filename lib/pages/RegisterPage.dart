import 'package:flutter/material.dart';
import 'package:iridescentangle/utils/ToastUtil.dart';
import 'package:iridescentangle/net/HttpService.dart';
import 'package:iridescentangle/utils/DioUtil.dart';
import 'package:iridescentangle/utils/UserUtil.dart';
class RegisterPage extends StatefulWidget {
  String name;
  RegisterPage({Key key,this.name}):super(key:key);
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static String name = '';
   TextEditingController username = new TextEditingController(text: name);
  TextEditingController pwd = new TextEditingController(text: ''); 
  TextEditingController rePwd = new TextEditingController(text: '');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initUserName();
  }
  void _initUserName(){
    if(widget.name != null){
      setState(() {
              name = widget.name;
            });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('注册'),centerTitle: true,),
      body: _renderBody(context),
    );
  }
  Widget _renderBody(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _nameInput(),
        _passwordInput(),
        _rePasswordInput(),
        _registerButton(),
      ],
    );
  }
  Widget _registerButton(){
    var width = MediaQuery.of(context).size.width;
    var registerButton = RaisedButton(
        onPressed: (){
          _toRegister();
        },
        textColor: Colors.white,
        color: Colors.blue,
        disabledColor: Colors.grey,
        elevation: 4.0,
        child: Text('注册',style: TextStyle(fontSize: 20.0),),

      );
    return Container(
      margin: EdgeInsets.all(20.0),
      // margin: EdgeInsets.fromLTRB(width / 6+5.0, 30.0, width/6+5.0, 5.0),
      width: width / 2.2,
      height: width / 8,
      child: registerButton,
    );
  }
  void _toRegister() async {
    String inputName = username.text;
    String password = pwd.text;
    String rePassword = rePwd.text;
    if(inputName.length == 0){
      ToastUtil.showToast('请检查用户名!');
      return;
    }
    if(password.length == 0 || rePassword.length == 0){
      ToastUtil.showToast('请检查密码输入!');
      return;
    }
    if(password != rePassword){
      ToastUtil.showToast('请确认密码输入一致!');
      return;
    }
    Map<String,String> map = Map();
    map['username'] = inputName;
    map['password'] = password;
    map['repassword'] = rePassword;
    DioUtil.post(HttpService.WANANDROID_REGISTER,(var data){
      UserUtil.localLogOut();
      ToastUtil.showToast('正在为您自动登录中!');
      _autoLogin(data['username'],password);
    },params: map,
    errorCallBack: (msg){
      ToastUtil.showToast(msg);
    });
  }
  void _autoLogin(String username,String password) async{
    Map<String,String> map = Map();
    map['username'] = username;
    map['password'] = password;
    DioUtil.post(HttpService.WANANDROID_LOGIN,
     (data){
      UserUtil.saveInfo(data['username']);
      Navigator.pop(context,1);
    },params: map,errorCallBack:
      (msg){
        ToastUtil.showToast(msg);
      }
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
     var pwdInput = TextField(
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
        child:pwdInput,)
    );
  }
  Widget _rePasswordInput(){
     var rePwdInput = TextField(
      controller: rePwd,
      obscureText: true,
      cursorColor: Colors.lightBlue,
      decoration: InputDecoration(
        labelText: '请确认密码',
        fillColor: Colors.lightBlue,
      ),
    );
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.fromLTRB(width/ 4, 5.0, width / 4, 5.0),
      child: Padding(
        padding:EdgeInsets.all(10.0),
        child:rePwdInput,)
    );
  }
}