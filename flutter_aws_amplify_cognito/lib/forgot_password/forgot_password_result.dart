import 'package:flutter_aws_amplify_cognito/common/user_code_delivery_details.dart';
import 'package:flutter_aws_amplify_cognito/forgot_password/forgot_password_state.dart';

class ForgotPasswordResult {
  final ForgotPasswordState _state;
  final UserCodeDeliveryDetails _parameters;

  ForgotPasswordResult(
      ForgotPasswordState state, UserCodeDeliveryDetails parameters)
      : _state = state,
        _parameters = parameters;

  ForgotPasswordState get state => _state;

  UserCodeDeliveryDetails get parameters => _parameters;
}
