import 'dart:async';

import 'package:flutter/services.dart';

class FlutterAwsAmplifyPubSub {
  static const MethodChannel _channel =
      const MethodChannel('flutter_aws_amplify_pubsub');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
