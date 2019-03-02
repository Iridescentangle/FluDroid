import './HttpService.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
const String TAG = "ERROR OCCURED";
Future searchDoubanMovie(String keyWord,int start) async{
  Response response;
  try {
    response = await Dio().get(douban_paths['search']+'q=$keyWord'+'&'+'start=$start',);
    if(response.statusCode == 200){
      return response.data;
    }else{
      print(TAG + response.statusCode.toString());
    }
  } catch (e) {
    print(TAG +e.toString());
  }
}