import 'package:dio/dio.dart';
import 'package:iridescentangle/net/HttpService.dart';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DioUtil {
  static const String GET = 'GET';
  static const String POST = 'POST';

  //get请求
  static void get(String url, Function successCallBack,
      {Map<String, String> params, Function errorCallBack}) {
    _request(url, successCallBack,
        method: GET, params: params, errorCallBack: errorCallBack);
  }

  //post请求
  static void post(String url, Function successCallBack,
      {Map<String, String> params, Function errorCallBack}) {
    _request(url, successCallBack,
        method: POST, params: params, errorCallBack: errorCallBack);
  }

  // 请求部分
  static void _request(String url, Function callBack,
      {String method, Map<String, String> params, Function errorCallBack}) async {
    String errorMsg = "";
    int statusCode;

    try {
      Response response;
      Options options= new Options(
        // 15s 超时时间
        connectTimeout:15000,
        receiveTimeout:15000,
        baseUrl: HttpService.WANANDROID_BASE_URL,
      // dio库中默认将请求数据序列化为json，此处可根据后台情况自行修改
        contentType: new ContentType('application', 'form-urlencoded',charset: 'utf-8'),
      );
      Dio dio = new Dio(options);
      // dio.cookieJar=new PersistCookieJar("./cookies");
      var cj = new CookieJar();
      dio.cookieJar = cj;
      
      if (method == GET) {
        response = await dio.get(url,data: params);
      } else {
        FormData formData = FormData.from(params);
        response = await dio.post(url,data: formData);
      }
      statusCode = response.statusCode;
      //处理错误部分
      if (statusCode < 0) {
        errorMsg = "网络请求错误,状态码:" + statusCode.toString();
        _handError(errorCallBack, errorMsg);
        return;
      }
      

      if (callBack != null) {
        callBack(response);
        // print(response.statusCode);
      }
    } catch (exception) {
      _handError(errorCallBack, exception.toString());
    }
  }
  //处理异常
  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
  }
  
}