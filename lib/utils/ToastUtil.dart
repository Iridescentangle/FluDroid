import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
class ToastUtil{
  static GlobalKey<ScaffoldState> scaffoldKey;
  static void showToast(String msg){
    Fluttertoast.showToast(msg:msg,toastLength: Toast.LENGTH_LONG,);
  }
}