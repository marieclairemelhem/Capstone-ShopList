import 'package:flutter/material.dart';
import 'splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'homescreen.dart';

void main() {
  runApp(new MaterialApp(
    home: _handleCurrentScreen(),
    title: 'ShopList',
  ));
}

Widget _handleCurrentScreen() {
  return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new SplashScreen();
        } else {
          if (snapshot.hasData) {
            return new HomeScreen(snapshot.data.uid);
          }
        }
        return new LoginScreen();
      });
}
