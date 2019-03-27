import 'package:flutter/material.dart';
import 'bottom_navigation_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'state/AppState.dart';
void main(){
  Store<AppState> store = Store<AppState>(
    mainReducer,
    initialState: AppState(
      login: LoginState(isLogin: false,account: null),
      main: MainPageState(counter: null),
      )
    );
  runApp(MyApp(store: store,));
}
class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        theme: ThemeData.light(),
        home: BottomNavigationWidget(),
      ),
    );
  }
}