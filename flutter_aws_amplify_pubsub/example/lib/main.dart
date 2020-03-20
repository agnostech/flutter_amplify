import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:flutter_aws_amplify_pubsub/flutter_aws_amplify_pubsub.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    FlutterAwsAmplifyCognito.initialize().then((UserStatus status) {
      print("from initialize");
      print(status);
      FlutterAwsAmplifyCognito.addUserStateListener.listen((UserStatus status) {
        print("from listener");
        print(status);
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: RaisedButton(
          onPressed: () {
//            Map<String, String> attributes = Map<String, String>();
//            attributes["name"] = "Vishal Dubey";
//            attributes["email"] = "yzvishal.vd@gmail.com";
//            FlutterAwsAmplifyCognito.signUp(
//                    "yzvishal.vd@gmail.com", "vishal69", attributes)
//                .then((SignUpResult result) {
//              print(result.);
//            }).catchError((error) {
//              print(error);
//            });
//            FlutterAwsAmplifyCognito.confirmSignUp("yzvishal.vd@gmail.com", "062813")
//                .then((SignUpResult result) {
//              print(result.confirmationState);
//            }).catchError((error) {
//              print(error);
//            });
            FlutterAwsAmplifyCognito.signIn("yzvishal.vd@gmail.com", "vishal69")
                .then((SignInResult result) {
                  //print(result.signInState);
            })
                .catchError((error) {
                  print("error");
                  print(error);
            });
          },
          child: Text('Sign up'),
        )),
      ),
    );
  }
}
