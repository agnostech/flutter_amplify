import 'package:flutter_aws_amplify_pubsub/qos/aws_iot_mqtt_qos.dart';

class AWSIotMqttLastWillAndTestament {
  final String _topic;
  final String _message;
  final int _qos;

  AWSIotMqttLastWillAndTestament(
      String topic, String message, int qos)
      : _topic = topic,
        _message = message,
        _qos = qos;

  String get topic => _topic;

  String get message => _message;

  int get qos => _qos;
}
