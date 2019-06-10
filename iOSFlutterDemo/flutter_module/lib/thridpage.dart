import 'package:flutter/material.dart';
void main()=>runApp(mytest());
class mytest extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(

      title: '这是第三页',
      home: createThridHome(),
    );
  }
}

class createThridHome extends StatefulWidget{

  @override
  thridHomePage createState() => new  thridHomePage();
}

class thridHomePage extends State<createThridHome>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

    );
  }
}
