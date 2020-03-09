import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_aws_amplify_cognito/common/common.dart';
import 'package:flutter_aws_amplify_cognito/common/flutter_cognito_user_status.dart';
import 'package:flutter_aws_amplify_cognito/forgot_password/forgot_password_result.dart';
import 'package:flutter_aws_amplify_cognito/forgot_password/forgot_password_state.dart';
import 'package:flutter_aws_amplify_cognito/sign_in/signin_result.dart';
import 'package:flutter_aws_amplify_cognito/sign_up/signup_result.dart';
import 'package:flutter_aws_amplify_cognito/common/user_code_delivery_details.dart';

export 'package:flutter_aws_amplify_cognito/common/flutter_cognito_user_status.dart';

class FlutterAwsAmplifyCognito {
  static const MethodChannel _methodChannel =
      const MethodChannel('flutter_aws_amplify_cognito/cognito');

  static const EventChannel _eventChannel =
      const EventChannel('flutter_aws_amplify_cognito/cognito_user_status');

  static Future<SignUpResult> signUp(String username, String password,
      Map<String, String> userAttributes) async {
    try {
      Map<String, dynamic> arguments = Map<String, String>();
      arguments['username'] = username;
      arguments['password'] = password;
      arguments['userAttributes'] = userAttributes;

      final signUpResult =
          await _methodChannel.invokeMethod("signUp", arguments);
      return SignUpResult(
          signUpResult['confirmationState'],
          UserCodeDeliveryDetails(signUpResult['destination'],
              signUpResult['deliveryMedium'], signUpResult['attributeName']));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<SignUpResult> confirmSignUp(
      String username, String code) async {
    try {
      Map<String, dynamic> arguments = Map<String, String>();
      arguments['username'] = username;
      arguments['code'] = code;

      final signUpResult =
          await _methodChannel.invokeMethod("confirmSignUp", arguments);
      return SignUpResult(
          signUpResult['confirmationState'],
          UserCodeDeliveryDetails(signUpResult['destination'],
              signUpResult['deliveryMedium'], signUpResult['attributeName']));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<SignUpResult> resendSignUp(String username) async {
    try {
      Map<String, dynamic> arguments = Map<String, String>();
      arguments['username'] = username;

      final signUpResult =
          await _methodChannel.invokeMethod("resendSignUp", arguments);
      return SignUpResult(
          signUpResult['confirmationState'],
          UserCodeDeliveryDetails(signUpResult['destination'],
              signUpResult['deliveryMedium'], signUpResult['attributeName']));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<SignInResult> signIn(String username, String password) async {
    try {
      Map<String, dynamic> arguments = Map<String, String>();
      arguments['username'] = username;
      arguments['password'] = password;

      final signInResult =
          await _methodChannel.invokeMethod("signIn", arguments);

      return SignInResult(
          parseSignInState(signInResult['signInState']),
          signInResult['parameters'],
          UserCodeDeliveryDetails(signInResult['destination'],
              signInResult['deliveryMedium'], signInResult['attributeName']));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<SignInResult> confirmSignIn(
      String confirmSignInChallenge) async {
    try {
      Map<String, dynamic> arguments = Map<String, String>();
      arguments['confirmSignInChallenge'] = confirmSignInChallenge;

      final signInResult =
          await _methodChannel.invokeMethod("confirmSignIn", arguments);

      return SignInResult(
          parseSignInState(signInResult['signInState']),
          signInResult['parameters'],
          UserCodeDeliveryDetails(signInResult['destination'],
              signInResult['deliveryMedium'], signInResult['attributeName']));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<ForgotPasswordResult> forgotPassword(String username) async {
    try {
      Map<String, dynamic> arguments = Map<String, String>();
      arguments['username'] = username;

      final forgotPasswordResult =
          await _methodChannel.invokeMethod("forgotPassword", arguments);

      return ForgotPasswordResult(
          parseForgotPasswordState(forgotPasswordResult['state']),
          UserCodeDeliveryDetails(
              forgotPasswordResult['destination'],
              forgotPasswordResult['deliveryMedium'],
              forgotPasswordResult['attributeName']));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<ForgotPasswordResult> confirmForgotPassword(
      String username, String newPassword, String confirmationCode) async {
    try {
      Map<String, dynamic> arguments = Map<String, String>();
      arguments['newPassword'] = newPassword;
      arguments['confirmationCode'] = confirmationCode;

      final forgotPasswordResult =
          await _methodChannel.invokeMethod("confirmForgotPassword", arguments);

      return ForgotPasswordResult(
          parseForgotPasswordState(forgotPasswordResult['state']),
          UserCodeDeliveryDetails(
              forgotPasswordResult['destination'],
              forgotPasswordResult['deliveryMedium'],
              forgotPasswordResult['attributeName']));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<FlutterCognitoUserStatus> initialize() async {
    try {
      return parseUserStatus(await _methodChannel.invokeMethod("initialize"));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<bool> isSignedIn() async {
    try {
      return await _methodChannel.invokeMethod("isSignedIn");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<FlutterCognitoUserStatus> currentUserStatus() async {
    try {
      return parseUserStatus(
          await _methodChannel.invokeMethod("currentUserState"));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<void> signOut() async {
    try {
      await _methodChannel.invokeMethod("signOut");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<bool> signOutGlobally() async {
    try {
      return await _methodChannel.invokeMethod("signOutGlobally");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<Map<String, String>> getUserAttributes() async {
    try {
      return await _methodChannel.invokeMethod("getUserAttributes");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> getUsername() async {
    try {
      return await _methodChannel.invokeMethod("getUsername");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> getIdentityId() async {
    try {
      return await _methodChannel.invokeMethod("getIdentityId");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<Map<String, String>> getTokens() async {
    try {
      return await _methodChannel.invokeMethod("getTokens");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> getIdToken() async {
    try {
      return await _methodChannel.invokeMethod("getIdToken");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> getAccessToken() async {
    try {
      return await _methodChannel.invokeMethod("getAccessToken");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> getRefreshToken() async {
    try {
      return await _methodChannel.invokeMethod("");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<Map<String, String>> getCredentials() async {
    try {
      return await _methodChannel.invokeMethod("getCredentials");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<bool> trackDevice() async {
    try {
      return await _methodChannel.invokeMethod("trackDevice");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<bool> untrackDevice() async {
    try {
      return await _methodChannel.invokeMethod("untrackDevice");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<bool> forgetDevice() async {
    try {
      return await _methodChannel.invokeMethod("forgetDevice");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Future<Map<String, String>> getDeviceDetails() async {
    try {
      return await _methodChannel.invokeMethod("getDeviceDetails");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  static Stream<FlutterCognitoUserStatus> get onUserStatusChange {
    return _eventChannel
        .receiveBroadcastStream()
        .map((event) => event.toString())
        .map(parseUserStatus);
  }
}
