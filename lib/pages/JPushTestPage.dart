import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
class JPushTestPage extends StatefulWidget {
  final Widget child;

  JPushTestPage({Key key, this.child}) : super(key: key);

  _JPushTestPageState createState() => _JPushTestPageState();
}

class _JPushTestPageState extends State<JPushTestPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _startupJpush();
    _setPushTag();
    _addEventHandler();
    _getRegisterID();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Jpush_test1'),
      ),
      body: Column(
        children: <Widget>[
          Text('极光后台来的msg=$myMsg'),
        ],
      ),
    );
  }

  JPush jPush = new JPush();
  String registerId = null;
  String myMsg;

  _startupJpush() {
    jPush.setup(appKey: "316bd598d801b822aa1651f8", debug: true);
  }

  _getRegisterID() async {
    registerId = await jPush.getRegistrationID();
    print('registerid=' + registerId);
    return registerId;
  }

  _setPushTag() {
    List<String> tags = List<String>();
    tags.add("jason");
    jPush.setTags(tags);
  }

  _addEventHandler() {
// Future<dynamic>event;
    jPush.addEventHandler(onReceiveNotification: (Map<String, dynamic> event) {
      print('addOnreceive>>>>>>$event');
      //addOnreceive>>>>>>{extras: {cn.jpush.android.ALERT_TYPE: 7, cn.jpush.android.EXTRA: {},
      // cn.jpush.android.MSG_ID: 255447735, cn.jpush.android.ALERT: we are the best!, cn.jpush.android.NOTIFICATION_ID: 255447735}, alert: we are the best!, title: flutter_mvp}
      String msg="$event";
      _refreshData(msg);
    }, onOpenNotification: (Map<String, dynamic> event) {
      print('addOpenNoti>>>>>$event'); //分别测试过无效的
      print(event.toString());
    }, onReceiveMessage: (Map<String, dynamic> event) {
      print('addReceiveMsg>>>>>$event'); //无效的
      print(event.toString());
    });
  }

  //更新某个控件显示
  _refreshData(String msg) {
    setState(() {
      myMsg = msg;
    });
  }
}