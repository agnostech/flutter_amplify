class AWSIoTMessage {
  final String _payload;
  final String _topic;

  AWSIoTMessage(String payload, String topic)
      : _payload = payload,
        _topic = topic;

  String get payload => _payload;
  String get topic => _topic;
}
