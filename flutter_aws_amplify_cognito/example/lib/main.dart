import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:flutter_aws_amplify_cognito_example/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

    final List<Widget> components = [Authentication()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutterAmplify'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Authentication'),
              )
            ],
          ),
        ),
        body: components[0]
      ),
    );
  }
}
