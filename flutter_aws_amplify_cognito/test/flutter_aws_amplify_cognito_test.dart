import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';

void main() {
  const MethodChannel channel =
      MethodChannel('flutter_aws_amplify_cognito/cognito');
  //const EventChannel eventChannel = EventChannel('flutter_aws_amplify_cognito/cognito_user_status');

  TestWidgetsFlutterBinding.ensureInitialized();
  //Stream<dynamic> userStateListener;

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'isSignedIn':
          return false;
          break;
        case 'initialize':
          return "SIGNED_OUT";
          break;
        case 'currentUserState':
          return 'SIGNED_OUT';
        case 'signOutGlobally':
          return true;
        case 'getUserAttributes':
          Map<String, String> data = Map<String, String>();
          data['email'] = "yzvishal.vd@gmail.com";
          return data;
        case 'getUsername':
          return 'vishal';
        case 'getTokens':
          Map<String, String> data = Map<String, String>();
          data['accessToken'] = 'accessToken';
          data['idToken'] = 'idToken';
          data['refreshToken'] = 'refreshToken';
          return data;
        case "getIdToken":
          return "idToken";
        case "getAccessToken":
          return "accessToken";
        case "getRefreshToken":
          return "refreshToken";
        case "getCredentials":
          Map<String, String> data = Map<String, String>();
          data['accessKey'] = "accessKey";
          data['secretKey'] = "secretKey";
          return data;
        case "trackDevice":
          return true;
        case "untrackDevice":
          return true;
        case "forgetDevice":
          return true;
        case "getDeviceDetails":
          Map<String, dynamic> data = Map<String, dynamic>();
          Map<String, String> attr = Map<String, String>();
          attr['data'] = 'data';
          data['createDate'] = '${DateTime.now()}';
          data['deviceKey'] = 'pvc';
          data['lastAuthenticatedDate'] = '${DateTime.now()}';
          data['lastModifiedDate'] = '${DateTime.now()}';
          data['attributes'] = attr;
          return data;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('isSignedIn', () async {
    expect(await FlutterAwsAmplifyCognito.isSignedIn(), false);
  });

  test('initialize', () async {
    expect(await FlutterAwsAmplifyCognito.initialize(), UserStatus.SIGNED_OUT);
  });

  test('currentUserState', () async {
    expect(await FlutterAwsAmplifyCognito.currentUserState(),
        UserStatus.SIGNED_OUT);
  });

  test('signOutGlobally', () async {
    expect(await FlutterAwsAmplifyCognito.signOutGlobally(), true);
  });

  test('getUserAttributes', () async {
    expect((await FlutterAwsAmplifyCognito.getUserAttributes())['email'],
        'yzvishal.vd@gmail.com');
  });

  test('getUsername', () async {
    expect(await FlutterAwsAmplifyCognito.getUsername(), 'vishal');
  });

  test('getTokens', () async {
    expect((await FlutterAwsAmplifyCognito.getTokens()).accessToken,
        "accessToken");
  });

  test('getIdToken', () async {
    expect((await FlutterAwsAmplifyCognito.getIdToken()), "idToken");
  });

  test('getAccessToken', () async {
    expect((await FlutterAwsAmplifyCognito.getAccessToken()), "accessToken");
  });

  test('getRefreshToken', () async {
    expect((await FlutterAwsAmplifyCognito.getRefreshToken()), "refreshToken");
  });

  test('getCredentials', () async {
    expect((await FlutterAwsAmplifyCognito.getCredentials()).secretKey,
        'secretKey');
  });

  test('trackDevice', () async {
    expect(await FlutterAwsAmplifyCognito.trackDevice(), true);
  });

  test('untrackDevice', () async {
    expect(await FlutterAwsAmplifyCognito.untrackDevice(), true);
  });

  test('forgetDevice', () async {
    expect(await FlutterAwsAmplifyCognito.forgetDevice(), true);
  });

  test('getDeviceDetails', () async {
    expect((await FlutterAwsAmplifyCognito.getDeviceDetails()).attributes['data'], 'data');
  });
}
