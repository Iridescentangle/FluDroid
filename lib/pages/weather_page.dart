import 'package:flutter/material.dart';
import 'city_select_page.dart';
import 'package:sky_engine/_http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'city_select_page.dart';
import 'package:flutter/cupertino.dart';

class WeatherPage extends StatefulWidget {
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>  with SingleTickerProviderStateMixin{
  String city = "bei jing shi";
  String city_name = "北京市";
  String tmp = '';
  var fl = '';
  var hum ='';
  var cond_txt = '';
  var loc = '';
  var wind_sc = '';
  var wind_dir = '';
  bool hasData = false;
  @override
  void initState() {
    loadData(city);
    super.initState();
  }
  @override
  bool get wantKeepAlive => true;
 
  @override
  void dispose() {
    super.dispose();
  }
  void loadData(String cityName) async{
    String key = "fcb1681f7ffd4a44a6ccda9786014341";
    String url = "https://free-api.heweather.net/s6/weather/now?";
    var requestUrl = url+"location="+city+"&key="+key;
    var httpClient = new HttpClient();
    // var uri = new Uri.http(
    //   'example.com', '/path1/path2', {'param1': '42', 'param2': 'foo'});
    var uri1 = Uri.parse(requestUrl);
    var request = await httpClient.getUrl(uri1);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var result = json.decode(responseBody);
    // setState(() {
      var weather = result['HeWeather6'][0];
      if(weather['status'] == "ok"){
        var now = weather['now'];
        setState(() {
                  hasData = true;
                  city_name = weather['basic']['location'];
                  tmp = '${now['tmp']}';
                  fl = now['fl'];
                  hum = now['hum'];
                  cond_txt = now['cond_txt'];
                  loc = weather['update']['loc'];
                  wind_dir = now['wind_dir'];
                  wind_sc = now['wind_sc'];
                });
      }
    // });
  }
  @override
  Widget build(BuildContext context) {
    Widget body;
    if(!hasData){
      return Scaffold(appBar:AppBar(title: Text('天气'),centerTitle: true,),body:Center(child:CupertinoActivityIndicator()));
    }else{
      body =  Stack(
        children: <Widget>[
          Stack(
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints.expand(),
                      child:Image.asset('assets/images/beijing.jpg',fit: BoxFit.fill,),
                      ),
                    Center(
                        child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7.0,sigmaY: 7.0),
                        child: Opacity(
                          opacity: 0.5,
                          child: Container(
                            width: 500.0,
                            height: 900.0,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        ),
                      ),
                  ],
                ),
            Positioned(
                    top: 5.0,
                    left: 5.0,
                    child: RaisedButton(
                      color: Colors.lightBlue.shade500,
                      onPressed: (){
                        _navigate_async('选择城市');
                      },
                      child: Container(
                        width: 100.0,
                        height: 50.0,
                        child:Row(
                          children: <Widget>[
                            Icon(Icons.search,color: Colors.white,),
                            Text('选择城市',style: TextStyle(color: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 300.0,
                    height: 130.0,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.all(10.0),
                    child:  Text('$city_name',style: TextStyle(color: Colors.white,fontSize: 45.0),),
                  ),
                  Container(
                    width: 300.0,
                    height: 60.0,
                    margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                    alignment: Alignment.topCenter,
                    child: Text('${cond_txt}',style: TextStyle(color: Colors.white,fontSize: 65.0),),
                    
                  ),
                  Container(
                    width: 300.0,
                    height: 10.0,
                    margin: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
                    alignment: Alignment.topCenter,
                    child: Text('${tmp}℃',style: TextStyle(color: Colors.white,fontSize: 65.0),),
                    
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
                    width: 200.0,
                    child: 
                        Row(
                          children: <Widget>[
                            Expanded(
                              child:
                                  Container(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  children: <Widget>[
                                    Text('相对湿度',style: TextStyle(color: Colors.grey.shade200),),
                                    Text('${hum}',style:TextStyle(color:Colors.white,fontSize:25.0)),
                                  ],
                                  ),
                                ),
                            ),
                            Expanded(
                                child: Container(
                                alignment: Alignment.bottomRight,
                                child: Column(
                                  children: <Widget>[
                                    Text('体感温度',style: TextStyle(color: Colors.grey.shade200),),
                                    Text('${fl}℃',style:TextStyle(color:Colors.white,fontSize:25.0)),
                                  ],
                                ),
                              ),
                            ),
                              
                              
                          ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                      height: 50.0,
                      child: Center(
                        child:Text(
                          '更新于当地时间:${loc}',
                          style: TextStyle(color: Colors.white,fontSize: 20.0),
                          ),
                        ),
                    ),  
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                      child: Center(
                        child:Text(
                          '今天风向是${wind_dir},风力约${wind_sc}级',
                          style: TextStyle(color: Colors.white,fontSize: 20.0),
                          ),
                        ),
                    ),  
                
                ],
              ),
              ],
            ), 
        ]
      );
      return Scaffold(
        appBar: AppBar(title: Text('天气'),centerTitle: true,),
        body:body,
      );
    }
  }
  _navigate_async(String title) async{
      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context)=>CitySelectPage('选择城市')
                        )
                      );
      setState(() {
                city = result.namePinyin;
      });
      loadData(city);
  }
}