import 'package:flutter_aws_amplify_cognito/common/user_code_delivery_details.dart';
import 'package:flutter_aws_amplify_cognito/sign_in/signin_state.dart';

class SignInResult {
  final SignInState _signInState;
  final Map<String, String> _parameters;
  final UserCodeDeliveryDetails _codeDetails;

  SignInResult(SignInState signInState, Map<String, String> parameters,
      UserCodeDeliveryDetails codeDetails)
      : _signInState = signInState,
        _parameters = parameters,
        _codeDetails = codeDetails;

  SignInState get signInState => _signInState;

  Map<String, String> get parameters => _parameters;

  UserCodeDeliveryDetails get codeDetails => _codeDetails;
}
