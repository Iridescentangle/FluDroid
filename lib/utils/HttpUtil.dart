import 'package:http/http.dart' as http;
import 'package:iridescentangle/net/HttpService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
class HttpUtil {
    static const String GET = "get";
    static const String POST = "post";
    static String base_Url = "";
    static void setBaseUrl({String baseUrl}){
      if(baseUrl==null || baseUrl.length ==0){
        baseUrl = HttpService.WANANDROID_BASE_URL;
        return;
      }
      base_Url = baseUrl;

    }
  //get请求
  static void get(String url, Function callback, {Map<String, String> params,
        Map<String, String> headers, Function errorCallback}) async {
    if (!url.startsWith("http")) {
      url = base_Url + url;
    }
    //做非空判断
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    await startRequest(url, callback, method: GET, headers: headers,
        errorCallback: errorCallback);
  }
  static void post(String url, Function callback, {Map<String, String> params,
    Map<String, String> headers, Function errorCallback}) async {
    if (!url.startsWith("http")) {
      url = HttpService.WANANDROID_BASE_URL + url;
    }
    await startRequest(url, callback, method: POST,
        headers: headers, params: params, errorCallback: errorCallback);
  }
  //开始网络请求
  static Future startRequest(String url, Function callback, {String method,
    Map<String, String> headers, Map<String, String> params,
        Function errorCallback}) async {
    String errorMsg;
    int errorCode;
    var data;
    try {
      Map<String, String> headerMap = headers == null ? new Map() : headers;
      Map<String, String> paramMap = params == null ? new Map() : params;
      SharedPreferences sp = await SharedPreferences.getInstance();
      String cookie = sp.get("cookie");
      if(cookie==null || cookie.length==0){
      }else{
        headerMap['Cookie'] = cookie;
      }
      http.Response res;
      if (POST == method) {
        FormData formData = FormData.from(paramMap);
        res = await http.post(url, headers: headerMap, body: formData);
      } else {
        res = await http.get(url, headers: headerMap);
      }
//       print(res.body);

      if (res.statusCode != 200) {
        errorMsg = "网络请求错误,状态码:" + res.statusCode.toString();
        handError(errorCallback, errorMsg);
        return;
      }

      //以下部分可以根据自己业务需求封装,这里是errorCode>=0则为请求成功,data里的是数据部分
      //记得Map中的泛型为dynamic
      Map<String, dynamic> map = json.decode(res.body);

      errorCode = map['errorCode'];
      errorMsg = map['errorMsg'];
      data = map['data'];

      if(url.contains("login")){
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("cookie", res.headers['set-cookie']);
      }
      //callback返回data,数据类型为dynamic
      //errorCallback中为了方便我直接返回了String类型的errorMsg
      if (callback != null) {
        if (errorCode >= 0) {
          callback(data);
        } else {
          handError(errorCallback, errorMsg);
        }
      }
    } catch (exception) {
      handError(errorCallback, exception.toString());
    }
  }
  static void handError(Function errorCallback,String errorMsg){
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
  }

}