import 'package:flutter/material.dart';
import 'bottom_navigation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: BottomNavigationWidget(),
    );
  }
}