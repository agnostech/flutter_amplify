import Flutter
import UIKit

public class SwiftFlutterawsamplifypubsubPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutterawsamplifypubsub", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterawsamplifypubsubPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
