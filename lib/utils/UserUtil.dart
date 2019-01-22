import 'package:shared_preferences/shared_preferences.dart';
class UserUtil{
  static const String USER_NAME = 'username';
  static const String IS_LOGIN = 'is_login';
  static void saveInfo(String userName) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(USER_NAME, userName);
    sp.setBool(IS_LOGIN, true);
  }
  static void localLogOut() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(USER_NAME);
    sp.setBool(IS_LOGIN, false);
  }
   //获取用户名
  static Future<String> getUserName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String username =  sp.getString(USER_NAME);
    return username;
  }
  //判断当前是否有用户的登录信息
  static Future<bool> isLogin() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(IS_LOGIN);
  }
}