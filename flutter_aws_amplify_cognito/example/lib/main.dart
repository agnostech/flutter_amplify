import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';

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

  Future<void> initPlatformState() async {
    FlutterAwsAmplifyCognito.initialize()
        .then((FlutterCognitoUserStatus status) {
          setState(() {
            _platformVersion = status.toString();
          });
    }).catchError((error) {
      print(error);
    });

    FlutterAwsAmplifyCognito.currentUserStatus()
    .then((value) => print(value))
    .catchError((error) => print(error));

    FlutterAwsAmplifyCognito.isSignedIn().then((value) => print(value)).catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Current User Status: $_platformVersion\n'),
        ),
      ),
    );
  }
}
