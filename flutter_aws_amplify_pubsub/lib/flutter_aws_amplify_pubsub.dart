import 'package:flutter/services.dart';

class FlutterAwsAmplifyPubSub {
  static const MethodChannel _methodChannel =
      const MethodChannel('flutter_aws_amplify_pubsub');

  static const EventChannel connectionEvent =
      const EventChannel('flutter_aws_amplify_pubsub/pubsub_conn');

  static const EventChannel messagesEvent =
      const EventChannel('flutter_aws_amplify_pubsub/sub');



}
