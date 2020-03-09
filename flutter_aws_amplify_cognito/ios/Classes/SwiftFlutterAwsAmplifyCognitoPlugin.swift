import Flutter
import UIKit

public class SwiftFlutterAwsAmplifyCognitoPlugin: NSObject, FlutterPlugin {
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let methodChannel = FlutterMethodChannel(name: "flutter_aws_amplify_cognito/cognito", binaryMessenger: registrar.messenger())
        methodChannel.setMethodCallHandler(handleMethodCall)
        
        let eventChannel = FlutterEventChannel(name: "flutter_aws_amplify_cognito/cognito_user_status", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(CognitoUserStatusReceiver())
    }
}
