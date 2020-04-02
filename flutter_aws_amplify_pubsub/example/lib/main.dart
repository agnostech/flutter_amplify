import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:flutter_aws_amplify_pubsub/flutter_aws_amplify_pubsub.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _platformVersion = true;

  @override
  void initState() {
    super.initState();
    initPlatformState();
//    FlutterAwsAmplifyCognito.initialize()
//    .then((value) => print(value));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      UserStatus status = await FlutterAwsAmplifyCognito.initialize();
      print(status);
      String id = await FlutterAwsAmplifyCognito.getIdentityId();
      print(id);
      bool isInitialized = await FlutterAwsAmplifyPubSub.initialize(
          "iot-mobile1", "a1b9wu8ptcvv1b.iot.us-west-2.amazonaws.com");
      print(isInitialized);
      bool attachedPolicy =
          await FlutterAwsAmplifyPubSub.attachPolicy("iot-test", "us-west-2");
      print(attachedPolicy);
      FlutterAwsAmplifyPubSub.getConnectionStatusAndMessages
      .listen((data) {
        print(data);
        if (data is AWSIoTMessage) {
          print(data.topic);
          print(data.payload);
        } else {
          if (data == AWSIoTConnectionStatus.Connected) {
            FlutterAwsAmplifyPubSub.subscribeToTopic(
                "iot-flutter", AWSIotMqttQos.QOS0)
                .then((value) => print(value))
                .catchError((error) => print(error));
            FlutterAwsAmplifyPubSub.subscribeToTopic(
                r'''$aws/things/vishalaf-bed/shadow/update/accepted''', AWSIotMqttQos.QOS0)
                .then((value) => print(value))
                .catchError((error) => print(error));
          }
        }
      });
//      FlutterAwsAmplifyPubSub.getConnectionStatus
//          .listen((AWSIoTConnectionStatus status){
//            print(status);
//            print(status == AWSIoTConnectionStatus.Connected);
//        if (status == AWSIoTConnectionStatus.Connected) {
//          FlutterAwsAmplifyPubSub.subscribeToTopic(
//              "iot-flutter", AWSIotMqttQos.QOS0).then((value) => print(value)).catchError((error) => print(error));
//        }
//      });

//      FlutterAwsAmplifyPubSub.getMessages.listen((AWSIoTMessage message) {
//        print(message.topic);
//        print(message.payload);
//      });

      bool connection = await FlutterAwsAmplifyPubSub.connect();
      print(connection);

    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: RaisedButton(
                child: Text('Send Message'),
                onPressed: () async {
                  final sent = await FlutterAwsAmplifyPubSub.publishString(jsonEncode({"state": {"desired": {"one": 0, "two": 0, "three": 0, "four": 1}}}), r'''$aws/things/vishalaf-bed/shadow/update''', 1);
                  setState(() {
                    _platformVersion = !_platformVersion;
                  });
                },
              ),
            ),
            Container(
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
                  print(result.signInState);
                  print(result.codeDetails);
                }).catchError((error) {
                  print("error");
                  print(error);
                });
              },
              child: Text('Sign up'),
            )),
          ],
        ),
      ),
    );
  }
}
