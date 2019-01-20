import 'package:shared_preferences/shared_preferences.dart';
class UserUtil{
  static const String USER_NAME = 'username';
  static void saveInfo(String userName) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(USER_NAME, userName);
  }
  static Future<bool> localLogOut() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear().then((suc){
      sp.setString(USER_NAME, null);
      return suc;
    });
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
    String username = sp.getString(USER_NAME);
    return username != null && username.length > 0 ;
  }
}