import 'package:flutter_aws_amplify_pubsub/common/connection_status.dart';
import 'package:flutter_aws_amplify_pubsub/common/message.dart';

AWSIoTConnectionStatus parseConnectionStatus(String status) {
  switch (status) {
    case "Connecting":
      return AWSIoTConnectionStatus.Connecting;
    case "Connected":
      return AWSIoTConnectionStatus.Connected;
    case "Reconnecting":
      return AWSIoTConnectionStatus.Reconnecting;
    case "ConnectionLost":
      return AWSIoTConnectionStatus.ConnectionLost;
    default:
      return AWSIoTConnectionStatus.Unknown;
  }
}

AWSIoTMessage parseMqttMessage(Map<String, dynamic> message) {
  return AWSIoTMessage(message['data'], message['topic']);
}
