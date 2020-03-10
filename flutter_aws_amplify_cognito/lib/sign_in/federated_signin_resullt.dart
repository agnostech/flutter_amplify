import 'package:flutter_aws_amplify_cognito/common/user_status.dart';

class FederatedSignInResult {
  final UserStatus _userState;
  final Map<String, String> _details;

  FederatedSignInResult(UserStatus userState, Map<String, String> details)
      : _userState = userState,
        _details = details;

  UserStatus get userStatus => _userState;
  Map<String, String> get details => _details;
}
