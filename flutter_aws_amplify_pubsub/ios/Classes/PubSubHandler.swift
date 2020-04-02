//
//  PubSubHandler.swift
//  flutter_aws_amplify_pubsub
//
//  Created by Vishal Dubey on 13/03/20.
//

import Foundation

class PubSubHandler: NSObject, FlutterStreamHandler  {
    
    static let shared = PubSubHandler()
    
    override init() {
        
    }
    
    var eventChannel: FlutterEventSink?
    
    func handleMethodaCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any] ?? [:]
        switch call.method {
        case "initialize":
            SwiftFlutterAwsAmplifyPubSub.initialize(result: result, mqttClientId: arguments["mqttClientId"] as! String, awsIoTEndPointUrl: arguments["awsIoTEndPointUrl"] as! String)
        case "attachPolicy":
            SwiftFlutterAwsAmplifyPubSub.attachPolicy(result: result, policyName: arguments["policyName"] as! String, awsRegion: arguments["awsRegion"] as! String)
        case "subscribeToTopic":
            SwiftFlutterAwsAmplifyPubSub.subscribeToTopic(result: result, messageEvent: eventChannel!, subscriptionTopic: arguments["subscriptionTopic"] as! String, qos: arguments["qos"] as! Int)
        case "connect":
            SwiftFlutterAwsAmplifyPubSub.connect(result: result, connectEvent: eventChannel!)
        case "publishString":
            SwiftFlutterAwsAmplifyPubSub.publishString(result: result, payload: arguments["payload"] as! String, topic: arguments["topic"] as! String, qos: arguments["qos"] as! Int)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print("called listener")
        eventChannel = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        
        return nil
    }
    
}
