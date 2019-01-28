import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
    String user_id;

  HomeScreen(@required this.user_id){
   user_id=this.user_id;
  } 
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('HomeScreen'),
      ),
      body: new Center(
        child: new Text('Welcome  Home.!'),
      ),
    );
  }
}