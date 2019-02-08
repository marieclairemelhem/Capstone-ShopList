import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
   String uid = "";
  HomeScreen({Key key, @required this.uid}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Screen"),
      ),
      body: new Center(
        child: new Text(widget.uid),
      ),
    );
  }


}
