import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_aws_amplify_cognito/common/common.dart';
import 'package:flutter_aws_amplify_cognito/common/user_status.dart';
import 'package:flutter_aws_amplify_cognito/credentials/aws_credentials.dart';
import 'package:flutter_aws_amplify_cognito/device/device.dart';
import 'package:flutter_aws_amplify_cognito/forgot_password/forgot_password_result.dart';
import 'package:flutter_aws_amplify_cognito/sign_in/federated_signin_resullt.dart';
import 'package:flutter_aws_amplify_cognito/sign_in/signin_result.dart';
import 'package:flutter_aws_amplify_cognito/sign_in/signin_state.dart';
import 'package:flutter_aws_amplify_cognito/sign_up/signup_result.dart';
import 'package:flutter_aws_amplify_cognito/common/user_code_delivery_details.dart';
import 'package:flutter_aws_amplify_cognito/tokens/tokens.dart';

export 'package:flutter_aws_amplify_cognito/common/user_status.dart';
export 'package:flutter_aws_amplify_cognito/common/user_code_delivery_details.dart';

export 'package:flutter_aws_amplify_cognito/sign_up/signup_result.dart';
export 'package:flutter_aws_amplify_cognito/sign_in/signin_result.dart';
export 'package:flutter_aws_amplify_cognito/sign_in/signin_state.dart';
export 'package:flutter_aws_amplify_cognito/forgot_password/forgot_password_result.dart';
export 'package:flutter_aws_amplify_cognito/forgot_password/forgot_password_state.dart';
export 'package:flutter_aws_amplify_cognito/tokens/tokens.dart';
export 'package:flutter_aws_amplify_cognito/credentials/aws_credentials.dart';

export 'package:flutter_aws_amplify_cognito/sign_in/federated_signin_resullt.dart';
export 'package:flutter_aws_amplify_cognito/sign_in/identity_provider.dart';

export 'package:flutter_aws_amplify_cognito/device/device.dart';

class FlutterAwsAmplifyCognito {
  /// The main channel for communicating with native code for Android and iOS.
  static const MethodChannel _methodChannel =
      const MethodChannel('flutter_aws_amplify_cognito/cognito');

  /// A listener for keeping a track of user state change [UserStatus.SIGNED_OUT, UserStatus.SIGNED_IN, etc.].
  static const EventChannel _eventChannel =
      const EventChannel('flutter_aws_amplify_cognito/cognito_user_status');

  static Future<T> _invokeMethod<T>(
    String method, {
    Map<String, Object> arguments = const {},
  }) {
    return _methodChannel.invokeMethod(method, arguments);
  }

  /// Helps user sign up in the Cognito User Pool with the required user attributes[Map<String, String>]
  ///
  /// Response is a [SignUpResult] object holding the [confirmationState] and the [UserCodeDeliveryDetails]
  /// mentioning the details of confirmation code sent (For eg., in case of Multi Factor Authentication).
  static Future<SignUpResult> signUp(String username, String password,
      Map<String, String> userAttributes) async {
    try {
      Map<String, dynamic> arguments = Map<String, dynamic>();
      arguments['username'] = username;
      arguments['password'] = password;
      arguments['userAttributes'] = userAttributes;

      final signUpResult = await _invokeMethod("signUp", arguments: arguments);

      return SignUpResult(
          signUpResult['confirmationState'],
          UserCodeDeliveryDetails(
              signUpResult['destination'] ?? "",
              signUpResult['deliveryMedium'] ?? "",
              signUpResult['attributeName'] ?? ""));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Confirms a multi factor sign up request from user's [username] and confirmation [code].
  static Future<SignUpResult> confirmSignUp(
      String username, String code) async {
    try {
      final arguments = {
        'username': username,
        'code': code,
      };

      final signUpResult =
          await _invokeMethod("confirmSignUp", arguments: arguments);

      return SignUpResult(
        signUpResult['confirmationState'],
        UserCodeDeliveryDetails(
          signUpResult['destination'] ?? "",
          signUpResult['deliveryMedium'] ?? "",
          signUpResult['attributeName'] ?? "",
        ),
      );
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Re-sends a confirmation code for confirming user sign up in case of no/delayed confirmation code
  /// delivery via SMS/email.
  static Future<SignUpResult> resendSignUp(String username) async {
    try {
      Map<String, dynamic> arguments = Map<String, dynamic>();
      arguments['username'] = username;

      final signUpResult =
          await _invokeMethod("resendSignUp", arguments: arguments);
      return SignUpResult(
          signUpResult['confirmationState'],
          UserCodeDeliveryDetails(
              signUpResult['destination'] ?? "",
              signUpResult['deliveryMedium'] ?? "",
              signUpResult['attributeName'] ?? ""));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Signs in the user in the Cognito User Pool.
  ///
  /// Response is a [SignInResult] object containing the [SignInState], user attributes [Map<String, String>]
  /// and [UserCodeDeliveryDetails],
  static Future<SignInResult> signIn(String username, String password) async {
    try {
      Map<String, dynamic> arguments = Map<String, dynamic>();
      arguments['username'] = username;
      arguments['password'] = password;

      final signInResult = await _invokeMethod("signIn", arguments: arguments);

      return SignInResult(
          parseSignInState(signInResult['signInState']),
          Map<String, String>.from(
              signInResult['parameters'] ?? Map<String, String>()),
          UserCodeDeliveryDetails(
              signInResult['destination'] ?? "",
              signInResult['deliveryMedium'] ?? "",
              signInResult['attributeName'] ?? ""));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Sign in confirmation for multi factor enabled sign in.
  ///
  /// Response is a [SignInResult] object containing the [SignInState], user attributes [Map<String, String>]
  /// and [UserCodeDeliveryDetails].
  static Future<SignInResult> confirmSignIn(
      String confirmSignInChallenge) async {
    try {
      Map<String, dynamic> arguments = Map<String, dynamic>();
      arguments['confirmSignInChallenge'] = confirmSignInChallenge;

      final signInResult =
          await _invokeMethod("confirmSignIn", arguments: arguments);

      return SignInResult(
          parseSignInState(signInResult['signInState']),
          Map<String, String>.from(
              signInResult['parameters'] ?? Map<String, String>()),
          UserCodeDeliveryDetails(
              signInResult['destination'] ?? "",
              signInResult['deliveryMedium'] ?? "",
              signInResult['attributeName'] ?? ""));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Sends a confirmation code for resetting user's password using his/her [username].
  static Future<ForgotPasswordResult> forgotPassword(String username) async {
    try {
      Map<String, dynamic> arguments = Map<String, dynamic>();
      arguments['username'] = username;

      final forgotPasswordResult =
          await _invokeMethod("forgotPassword", arguments: arguments);

      return ForgotPasswordResult(
          parseForgotPasswordState(forgotPasswordResult['state']),
          UserCodeDeliveryDetails(
              forgotPasswordResult['destination'] ?? "",
              forgotPasswordResult['deliveryMedium'] ?? "",
              forgotPasswordResult['attributeName'] ?? ""));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Sets a new password using the [confirmationCode] and [newPassword] typed by the user.
  static Future<ForgotPasswordResult> confirmForgotPassword(
      String username, String newPassword, String confirmationCode) async {
    assert(username != null && username.length > 1);
    assert(newPassword != null && newPassword.length > 1);
    assert(confirmationCode != null && confirmationCode.length > 1);
    try {
      Map<String, String> arguments = {
        "newPassword": newPassword,
        "username": username,
        "confirmationCode": confirmationCode
      };

      final forgotPasswordResult =
          await _invokeMethod("confirmForgotPassword", arguments: arguments);

      return ForgotPasswordResult(
          parseForgotPasswordState(forgotPasswordResult['state']),
          UserCodeDeliveryDetails(
              forgotPasswordResult['destination'] ?? "",
              forgotPasswordResult['deliveryMedium'] ?? "",
              forgotPasswordResult['attributeName'] ?? ""));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Signs in a user in the Federated Identity Pool using a Federated Identity
  /// [IdentityProvider.GOOGLE, IdentityProvider.FACEBOOK, etc.].
  ///
  /// User has to mention the [identityProvider], the JWT [token] received after sign in
  ///
  /// For SAML based authentication, [customRoleARN] can be mentioned as a parameter.
  /// For Developer based custom authentication, a [cognitoIdentityId] can be mentioned.
  static Future<FederatedSignInResult> federatedSignIn(
      String identityProvider, String token,
      [String customRoleARN, String cognitoIdentityId]) async {
    try {
      Map<String, dynamic> arguments = Map<String, dynamic>();
      arguments['identityProvider'] = identityProvider;
      arguments['token'] = token;
      arguments['customRoleARN'] = customRoleARN;
      arguments['cognitoIdentityId'] = cognitoIdentityId;

      final result =
          await _invokeMethod('federatedSignIn', arguments: arguments);

      return FederatedSignInResult(parseUserStatus(result['userState']),
          Map<String, String>.from(result['userDetails']));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Initialize [AWSMobileClient] on the native side.
  ///
  /// Returns the current [UserStatus]
  static Future<UserStatus> initialize() async {
    try {
      return parseUserStatus(await _invokeMethod("initialize"));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Checks and returns true if the user is signed in.
  static Future<bool> isSignedIn() async {
    try {
      return await _invokeMethod("isSignedIn");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Checks the current user state and returns the [UserStatus].
  static Future<UserStatus> currentUserState() async {
    try {
      return parseUserStatus(await _invokeMethod("currentUserState"));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Signs out the user from the current application.
  static Future<void> signOut() async {
    try {
      await _invokeMethod("signOut");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Signs out the user globally from all the applications.
  static Future<bool> signOutGlobally() async {
    try {
      return await _invokeMethod("signOutGlobally");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Gets user attributes from the Cognito User Pool.
  static Future<Map<String, String>> getUserAttributes() async {
    try {
      final attributes = await _invokeMethod("getUserAttributes");
      return Map<String, String>.from(attributes);
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Retrieves the [username] for the current signed in user.
  static Future<String> getUsername() async {
    try {
      return await _invokeMethod("getUsername");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Retrieves the [identityId] for the current signed in user.
  static Future<String> getIdentityId() async {
    try {
      return await _invokeMethod("getIdentityId");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Retrieves the [Tokens] for the currently signed in user.
  static Future<Tokens> getTokens() async {
    try {
      final tokens = await _invokeMethod("getTokens");
      return Tokens(
          tokens['accessToken'], tokens['idToken'], tokens['refreshToken']);
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Retrieves the [idToken] for the currently signed in user.
  static Future<String> getIdToken() async {
    try {
      return await _invokeMethod("getIdToken");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Retrieves the [accessToken] for the currently signed in user.
  static Future<String> getAccessToken() async {
    try {
      return await _invokeMethod("getAccessToken");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Retrieves the [refreshToken] for the currently signed in user.
  static Future<String> getRefreshToken() async {
    try {
      return await _invokeMethod("getRefreshToken");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Retrieves the [AWSCredentials] for the currently signed in user.
  ///
  /// These credentials can be used to access other AWS services or can be
  /// exchanged for necessary certificates/credentials to use the other AWS services.
  static Future<AWSCredentials> getCredentials() async {
    try {
      final credentials = await _invokeMethod("getCredentials");
      return AWSCredentials(
          credentials['accessKeyId'], credentials['secretKey']);
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Sets the current user device has `remembered` in the Cognito User Pool.
  static Future<bool> trackDevice() async {
    try {
      return await _invokeMethod("trackDevice");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Sets the current user device has `not remembered` in the Cognito User Pool.
  static Future<bool> untrackDevice() async {
    try {
      return await _invokeMethod("untrackDevice");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Removes the current device affiliated with the user in the Cognito User Pool.
  static Future<bool> forgetDevice() async {
    try {
      return await _invokeMethod("forgetDevice");
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Gets the current device's details as a [Device] response object.
  static Future<Device> getDeviceDetails() async {
    try {
      var deviceDetails = await _invokeMethod("getDeviceDetails");

      return Device(
          DateTime.parse(deviceDetails['createDate']),
          deviceDetails['deviceKey'],
          DateTime.parse(deviceDetails['lastAuthenticatedDate']),
          DateTime.parse(deviceDetails['lastModifiedDate']),
          Map<String, String>.from(deviceDetails['attributes']));
    } on PlatformException catch (e) {
      return Future.error(e);
    }
  }

  /// Sets a listener to keep track of user State change
  ///
  /// [UserStatus] is received in the response.
  static Stream<UserStatus> get addUserStateListener {
    return _eventChannel
        .receiveBroadcastStream()
        .map((event) => event.toString())
        .map(parseUserStatus);
  }
}
