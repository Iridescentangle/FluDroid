import 'package:flutter/material.dart';
import 'package:iridescentangle/page_routes/FadePageRoute.dart';
class NavigatorUtil{
  static void navigateWithFade(BuildContext context,Widget widget){
    Navigator.push(context, FadePageRoute(widget));
  }
}