import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
class LoginState{
  String account;
  bool isLogin;
  LoginState({this.isLogin:false,this.account});
  @override
  String toString() {
    return "{account:$account,isLogin:$isLogin}";
  }
}
class MainPageState{
  int counter;
  MainPageState({this.counter:0});
   @override
  String toString() {
    return "{counter:$counter}";
  }
}
