class AWSCredentials {
  final String _accessKey;
  final String _secretKey;

  AWSCredentials(String accessKey, String secretKey)
      : _accessKey = accessKey,
        _secretKey = secretKey;

  String get accessKey => _accessKey;
  String get secretKey => _secretKey;
}
