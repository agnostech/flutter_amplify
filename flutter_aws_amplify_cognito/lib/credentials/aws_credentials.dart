class AWSCredentials {
  final String _accessKey;
  final String _secretKey;
  final String _sessionToken;

  AWSCredentials(String accessKey, String secretKey, String sessionToken)
      : _accessKey = accessKey,
        _secretKey = secretKey,
        _sessionToken = sessionToken;

  String get accessKey => _accessKey;

  String get secretKey => _secretKey;

  String get sessionToken => _sessionToken;
}
