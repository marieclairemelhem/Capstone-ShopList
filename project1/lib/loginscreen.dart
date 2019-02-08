import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/homescreen.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  String smsCode;
  String phoneNumber;
  String verificationCode; // verificationCode=sms+phonenumber//

  _saveUser(String userID) async {
    //saved the user in shared pref
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', userID);
  }

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationCode = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationCode = verId;
      smsCodeDialog(context).then((value) {
        print("smsCodeSent");
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
      print("verificationComplete");

      if (this.verificationCode != null && this.verificationCode == "") {
        _testSignInWithPhoneNumber(this.smsCode);

        print(' verificationcode $verificationCode');
      } else {
        print("autoverified");
        _auth.currentUser().then((user) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(uid: user.uid),
            ),
          );
        });
      }
    };

    final PhoneVerificationFailed verifiedFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await _auth.verifyPhoneNumber(
        phoneNumber: this.phoneNumber,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiedFailed);
  }

  _testSignInWithPhoneNumber(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: this.verificationCode,
      smsCode: this.smsCode,
    );

    await _auth.signInWithCredential(credential).then((user) async {
      final FirebaseUser currentUser = await _auth.currentUser();

      assert(user.uid == currentUser.uid);
      _saveUser(user.uid);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(uid: currentUser.uid),
        ),
      );
    }).catchError((error) {
      print("error $error");
    });
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text("Enter sms code"),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text("Done"),
                onPressed: () {
                  print(this.smsCode);
                  if (smsCode != null && smsCode != "") {
                    Navigator.of(context).pop();
                    _testSignInWithPhoneNumber(smsCode);
                  }
                },
              )
            ],
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('PhoneAuth'),
      ),
      body: new Center(
        child: Container(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Enter Phone number'),
                  onChanged: (value) {
                    this.phoneNumber = value;
                  },
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                    onPressed: verifyPhone,
                    child: Text('Verify'),
                    textColor: Colors.white,
                    elevation: 7.0,
                    color: Colors.blue)
              ],
            )),
      ),
    );
  }
}

