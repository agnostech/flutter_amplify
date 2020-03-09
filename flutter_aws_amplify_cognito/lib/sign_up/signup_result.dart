import 'package:flutter_aws_amplify_cognito/common/user_code_delivery_details.dart';

class SignUpResult {
  final bool _signUpConfirmationState;
  final UserCodeDeliveryDetails _cognitoUserCodeDeliveryDetails;

  SignUpResult(bool signUpConfirmationState,
      UserCodeDeliveryDetails cognitoUserCodeDeliveryDetails)
      : _signUpConfirmationState = signUpConfirmationState,
        _cognitoUserCodeDeliveryDetails = cognitoUserCodeDeliveryDetails;

  bool get confirmationState => _signUpConfirmationState;

  UserCodeDeliveryDetails get userCodeDeliveryDetails =>
      _cognitoUserCodeDeliveryDetails;
}
