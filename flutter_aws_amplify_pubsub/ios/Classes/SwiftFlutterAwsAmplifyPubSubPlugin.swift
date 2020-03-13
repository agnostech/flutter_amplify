import Flutter
import UIKit

public class SwiftFlutterAwsAmplifyPubSubPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let methodChannel = FlutterMethodChannel(name: "flutter_aws_amplify_pubsub/config", binaryMessenger: registrar.messenger())
    methodChannel.setMethodCallHandler(PubSubHandler.shared.handleMethodaCall)
    
    let subsChannel = FlutterEventChannel(name: "flutter_aws_amplify_pubsub/sub", binaryMessenger: registrar.messenger())
    subsChannel.setStreamHandler(PubSubHandler.shared)
    
    let connectionChannel = FlutterEventChannel(name: "flutter_aws_amplify_pubsub/pubsub_conn", binaryMessenger: registrar.messenger())
    connectionChannel.setStreamHandler(PubSubHandler.shared)
}

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
