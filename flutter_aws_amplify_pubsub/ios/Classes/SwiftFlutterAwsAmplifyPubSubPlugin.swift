import Flutter
import UIKit

public class SwiftFlutterAwsAmplifyPubSubPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let subsChannel = FlutterEventChannel(name: "flutter_aws_amplify_pubsub/subscriptions", binaryMessenger: registrar.messenger())
    subsChannel.setStreamHandler(PubSubHandler.shared)
    
    let methodChannel = FlutterMethodChannel(name: "flutter_aws_amplify_pubsub/config", binaryMessenger: registrar.messenger())
    methodChannel.setMethodCallHandler(PubSubHandler.shared.handleMethodaCall)
    }
}
