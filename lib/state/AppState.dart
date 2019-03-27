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
class AppState{
  LoginState login;
  MainPageState main;
  AppState({this.login,this.main});
}
AppState mainReducer(AppState state, dynamic action){


  print("state charge :$action ");
  // if(Actions.Increase==action){
  //   state.main.counter+=1;
  // }

  if(Actions.LogoutSuccess == action){

    state.login.isLogin = false;
    state.login.account = null;
  }

  if(action is LoginSuccessAction){
    state.login.isLogin = true;
    state.login.account = action.account;
  }

  print("state changed:$state");

  return state;
}
/// 定义所有action的基类
class Action{
  final Actions type;
  Action({this.type});
}
enum Actions{
  // Increase,
  Login,
  LoginSuccess,
  LogoutSuccess
}
/// 定义Login成功action
class LoginSuccessAction extends Action{

  final String account;

  LoginSuccessAction({
    this.account
}):super( type:Actions.LoginSuccess );
}
