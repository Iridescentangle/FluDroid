import 'package:flutter/material.dart';
import 'city_select_page.dart';
import 'package:sky_engine/_http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

class WeatherPage extends StatefulWidget {
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String city = "北京市";
  @override
    void initState() {
      super.initState();
      loadData(city);
    }
  void loadData(String cityName) async{
    String key = "fcb1681f7ffd4a44a6ccda9786014341";
    String url = "https://free-api.heweather.net/s6/weather/now?";
    var requestUrl = url+"location="+city+"&key="+key;
    print(requestUrl);
    var httpClient = new HttpClient();
    var uri = new Uri.http(
      'example.com', '/path1/path2', {'param1': '42', 'param2': 'foo'});
    var uri1 = Uri.parse(requestUrl);
    var request = await httpClient.getUrl(uri1);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    var result = json.decode(responseBody);
    // setState(() {
      var weather = result['HeWeather6'][0];
      if(weather['status'] == "ok"){
        var now = weather['now'];
        print(now['cond_txt'] + now['wind_dir']);
      }
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
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
           
            ]
      
      
    );
  }
  _navigate_async(String title) async{
      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context)=>CitySelectPage('选择城市')
                        )
                      );
      setState(() {
                city = result;
                loadData(city);
      });
  }
}