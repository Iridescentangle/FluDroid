import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SearchEmptyView extends StatelessWidget {
  final Widget child;

  SearchEmptyView({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: ScreenUtil.instance.setWidth(150),
              height: ScreenUtil.instance.setHeight(120),
              child: Image.asset('assets/images/no_data.png',),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenUtil.instance.setWidth(15)),
              child: Text('没有搜索到结果，换个词试试?',style:Theme.of(context).textTheme.subhead),
            ),
          ],
        ),
      );
  }
}