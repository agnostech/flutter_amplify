import 'package:flutter_aws_amplify_cognito/common/user_status.dart';
import 'package:flutter_aws_amplify_cognito/forgot_password/forgot_password_state.dart';
import 'package:flutter_aws_amplify_cognito/sign_in/signin_state.dart';

UserStatus parseUserStatus(String userStatus) {
  switch (userStatus) {
    case "GUEST":
      return UserStatus.GUEST;
    case "SIGNED_IN":
      return UserStatus.SIGNED_IN;
    case "SIGNED_OUT":
      return UserStatus.SIGNED_OUT;
    case "SIGNED_OUT_FEDERATED_TOKENS_INVALID":
      return UserStatus.SIGNED_OUT_FEDERATED_TOKENS_INVALID;
    case "SIGNED_OUT_USER_POOLS_TOKENS_INVALID":
      return UserStatus.SIGNED_OUT_USER_POOLS_TOKENS_INVALID;
    default:
      return UserStatus.ERROR;
  }
}

SignInState parseSignInState(String signInState) {
  switch (signInState) {
    case "SMS_MFA":
      return SignInState.SMS_MFA;
    case "PASSWORD_VERIFIER":
      return SignInState.PASSWORD_VERIFIER;
    case "CUSTOM_CHALLENGE":
      return SignInState.CUSTOM_CHALLENGE;
    case "DEVICE_SRP_AUTH":
      return SignInState.DEVICE_SRP_AUTH;
    case "DEVICE_PASSWORD_VERIFIER":
      return SignInState.DEVICE_PASSWORD_VERIFIER;
    case "ADMIN_NO_SRP_AUTH":
      return SignInState.ADMIN_NO_SRP_AUTH;
    case "NEW_PASSWORD_REQUIRED":
      return SignInState.NEW_PASSWORD_REQUIRED;
    case "DONE":
      return SignInState.DONE;
    case "UNKNOWN":
      return SignInState.UNKNOWN;
    default:
      return SignInState.ERROR;
  }
}

ForgotPasswordState parseForgotPasswordState(String forgotPasswordState) {
  switch (forgotPasswordState) {
    case "DONE":
      return ForgotPasswordState.DONE;
    case "CONFIRMATION_CODE":
      return ForgotPasswordState.CONFIRMATION_CODE;
    case "UNKNOWN":
      return ForgotPasswordState.UNKNOWN;
    default:
      return ForgotPasswordState.ERROR;
  }
}
