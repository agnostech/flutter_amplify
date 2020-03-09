import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_aws_amplify_cognito');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    //expect(await FlutterAwsAmplifyCognito.platformVersion, '42');
  });
}
