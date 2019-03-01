import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class NewPushPage extends StatefulWidget {
  @override
  _NewPushPageState createState() => _NewPushPageState();
}

class _NewPushPageState extends State<NewPushPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addEventHandler();
    _startupJpush();
    _set();
    _setPushTag();
    _getRegisterID();
  }

  JPush jPush = new JPush();
  String registerId = null;
  String myMsg="";

  _set(){
    var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + 1000);
    var localNotification = LocalNotification(
        id: 234,
        title: 'notification title',
        buildId: 1,
        content: 'notification content',
        fireTime: fireDate,
        subtitle: 'notification subtitle', // 该参数只有在 iOS 有效
        badge: 5, // 该参数只有在 iOS 有效
        extras: {"fa": "0"} // 设置 extras ，extras 需要是 Map<String, String>
    );
    jPush.sendLocalNotification(localNotification).then((res) {});
  }
  _startupJpush() {
    jPush.setup(appKey: "bf65d1eebaed2fb07602cd93", debug: true);
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
    jPush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> event) {
      print('addOnreceive>>>>>>$event');
     // String msg = "$event";
      String msg=event["alert"];
      print("Message==="+msg);
      _refreshData(msg);
    },
        onOpenNotification: (Map<String, dynamic> event) {
          print('addOpenNoti>>>>>$event'); //分别测试过无效的
          print(event.toString());
        },
        onReceiveMessage: (Map<String, dynamic> event) {
          print('addReceiveMsg>>>>>$event'); //无效的 print(event.toString());
        });
  } //更新某个控件显示
  _refreshData(String msg) {
    setState(() {
      myMsg = msg;
    });
  }
  _stopPush(){//停止推送功能
    jPush.stopPush();
  }
  _resumePush(){//调用 stopPush 后，可以通过 resumePush 方法恢复推送。
    jPush.resumePush();
  }
  _setAlias(){//设置别名，极光后台可以通过别名来推送，一个 App 应用只有一个别名，一般用来存储用户 id。
    jPush.setAlias("your alias").then((map) { });
  }
  _deleteAlias(){//可以通过 deleteAlias 方法来删除已经设置的 alias。
    jPush.deleteAlias().then((map) {});
  }
  _addTags(){//在原来的 Tags 列表上添加指定 tags。
    jPush.addTags(["tag1","tag2"]).then((map) {});
  }
  _deleteTags(){//在原来的 Tags 列表上删除指定 tags。
    jPush.deleteTags(["tag1","tag2"]).then((map) {});
  }


  @override Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Jpush_test1'),),
      body: Column(
        children: <Widget>[
          Text('极光后台来的msg=$myMsg'),
        ],),);
  }
}

