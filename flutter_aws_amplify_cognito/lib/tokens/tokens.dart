class Tokens {
  final String _accessToken;
  final String _idToken;
  final String _refreshToken;

  Tokens(String accessToken, String idToken, String refreshToken)
      : _accessToken = accessToken,
        _idToken = idToken,
        _refreshToken = refreshToken;

  String get accessToken => _accessToken;

  String get idToken => _idToken;

  String get refreshToken => _refreshToken;
}
