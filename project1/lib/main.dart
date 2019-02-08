import 'package:flutter/material.dart';
import 'launchscreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "ShopList",
        debugShowCheckedModeBanner: false,
        home: LaunchScreen());
  }
}
