import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginscreen.dart';
import 'homescreen.dart';

class LaunchScreen extends StatefulWidget {
  @override
  LaunchScreenState createState() => new LaunchScreenState();
}

class LaunchScreenState extends State<LaunchScreen> {
  String uid = "";
  bool loggedIn = false;
  Widget homeScreen;
  Widget loginScreen;
  Future<Null> _ensureLoggedIn() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    this.setState(() {
      if (prefs.getString("user") != null) {
        uid = prefs.getString("user");
        if (uid != "") {
          homeScreen = new HomeScreen(uid: uid);
        }
        loggedIn = true;
      } else {
        loginScreen = new LoginScreen();
        loggedIn = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "ShopList", home: loggedIn ? homeScreen : loginScreen);
  }

  @override
  void initState() {
    super.initState();
    this._ensureLoggedIn();
  }
}
