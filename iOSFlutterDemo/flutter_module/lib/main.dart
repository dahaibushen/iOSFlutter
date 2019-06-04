import 'dart:ui' as ui; // 调用window拿到route判断跳转哪个界面
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_module/HomePage.dart';


void main() => runApp(_widgetForRoute(ui.window.defaultRouteName));

//class _widgetForRoute extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return MaterialApp(
//      title: '11111',
//      home: homepage('sdsdsdsddds'),
//    );
//  }
//}

//关于在初始化的时候，待参数的启动问题，使用这种形式
Widget _widgetForRoute(String router){
    return new HomePage();
  switch (router) {
    case 'myApp':
      return new HomePage();
    case 'home':
      return new HomePage();
    default:
      return Center(
        child: Text('Unknown route: $router', textDirection: TextDirection.ltr),
      );
  }
}

//关于  StatelessWidget  StatefullWidget 带参数怎么处理 有疑问
//class MyApp extends StatelessWidget {
//
//  Widget HomePage(BuildContext context) {
//    return new HomePage(title: 'Flutter Demo Home Page');
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Flutter Demo',
//      theme: new ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      routes: <String, WidgetBuilder>{
//        "/home":(BuildContext context) => new HomePage(),
//      },
//      home: _home(context),
//    );
//  }
//}



class HomePage extends StatefulWidget {
//  _HomePageState({Key key, this.title}) : super(key:key);

//  final String title;

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // 注册一个通知
  static const EventChannel eventChannel = const EventChannel('com.pages.your/native_post');

  // 渲染前的操作，类似viewDidLoad
  @override
  void initState() {
    super.initState();

    // 监听事件，同时发送参数12345
    eventChannel.receiveBroadcastStream(12345678).listen(_onEvent,onError: _onError);
  }

  String naviTitle = 'title' ;
  // 回调事件
  void _onEvent(Object event) {
    setState(() {
      naviTitle =  event.toString();
    });
  }
  // 错误返回
  void _onError(Object error) {

  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Material(
        child: new Scaffold(
          body: new Center(
            child: new Text(naviTitle),
          ),
        ),
      ),
    );
  }


}