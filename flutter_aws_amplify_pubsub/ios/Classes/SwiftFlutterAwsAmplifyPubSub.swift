//
//  SwiftFlutterAwsAmplifyPubSub.swift
//  flutter_aws_amplify_pubsub
//
//  Created by Vishal Dubey on 13/03/20.
//

import Foundation
import AWSIoT
import AWSMobileClient

class SwiftFlutterAwsAmplifyPubSub {
    
    static var iotDataManager: AWSIoTDataManager?
    
    static func initialize(result: @escaping FlutterResult, mqttClientId: String, awsIoTEndPointUrl: String) {
        let iotEndPoint = AWSEndpoint(
            urlString: awsIoTEndPointUrl
        )
        let iotDataConfig = AWSServiceConfiguration(
            region: AWSRegionType.USWest2, endpoint: iotEndPoint, credentialsProvider: AWSMobileClient.default()
        )
        AWSIoTDataManager.register(with: iotDataConfig!, forKey: "flutterIoTConfig")
        AWSIoT.register(with: iotDataConfig!, forKey: "flutterIoTConfig")
        iotDataManager = AWSIoTDataManager(forKey: "flutterIoTConfig")
        result(true)
    }
    
    static func attachPolicy(result: @escaping FlutterResult, policyName: String, awsRegion: String) {
        let attachPolicyReq = AWSIoTAttachPolicyRequest()
        attachPolicyReq!.policyName = policyName
        attachPolicyReq!.target = AWSMobileClient.default().identityId
        AWSIoT(forKey: "flutterIoTConfig").attachPolicy(attachPolicyReq!)
            .continueWith(block: {
                (task) -> AnyObject? in
                if let error = task.error {
                    DispatchQueue.main.async {
                        result(FlutterError(code: "Error", message: "Error attaching policy", details: error.localizedDescription))
                    }
                }
                DispatchQueue.main.async {
                    result(true)
                }
                return nil
            })
    }
    
    static func setMetricsEnabled(result: @escaping FlutterResult, enabled: Bool) {
        do {
            try iotDataManager?.enableMetricsCollection(enabled)
            result(true)
        } catch let error {
            result(FlutterError(code: "Error", message: "Error enabling metrics", details: error.localizedDescription))
        }
    }
    
    static func isMetricsEnabled(result: @escaping FlutterResult) {
        result(true)
    }
    
    static func isAutoReconnect(result: @escaping FlutterResult) {
        result(true)
    }
    
    static func setAutoReconnect(result: @escaping FlutterResult, autoReconnect: Bool) {
        result(true)
    }
    
    static func setReconnectRetryLimits(result: @escaping FlutterResult, minTimeout: Int, maxTimeout: Int) {
        result(true)
    }
    
    static func getMinReconnectRetryTime(result: @escaping FlutterResult) {
        result(1)
    }
    
    static func getMaxReconnectRetryTime(result: @escaping FlutterResult) {
        result(128)
    }
    
    static func getMaxAutoReconnectAttempts(result: @escaping FlutterResult) {
        result(1)
    }
    
    static func setMaxAutoReconnectAttempts(result: @escaping FlutterResult) {
        result(true)
    }
    
    static func setConnectionStabilityTime(result: @escaping FlutterResult) {
        result(true)
    }
    
    static func getConnectionStabilityTime(result: @escaping FlutterResult) {
        result(1)
    }
    
    
    static func connect(result: @escaping FlutterResult, connectEvent: @escaping FlutterEventSink) {
        iotDataManager?.connectUsingWebSocket(withClientId: "ha-iot", cleanSession: false, statusCallback: { (status) in
            switch (status) {
            case .connected:
                DispatchQueue.main.async {
                    connectEvent(["type": "connection", "status": "Connected"])
                }
            case .connecting:
                DispatchQueue.main.async {
                    connectEvent(["type": "connection", "status": "Connecting"])
                }
            case .disconnected:
                DispatchQueue.main.async {
                    connectEvent(["type": "connection", "status": "ConnectionLost"])
                }
            case .connectionError:
                DispatchQueue.main.async {
                    connectEvent(["type": "connection", "status": "ConnectionError"])
                }
            case .connectionRefused:
                DispatchQueue.main.async {
                    connectEvent(["type": "connection", "status": "ConnectionRefused"])
                }
            case .protocolError:
                DispatchQueue.main.async {
                    connectEvent(["type": "connection", "status": "ProtocolError"])
                }
            case .unknown:
                DispatchQueue.main.async {
                    connectEvent(["type": "connection", "status": "Unknown"])
                }
            default:
                connectEvent(FlutterError(code: "Error", message: "Error getting connection status", details: ""))
            }
        })
        result(true)
    }
    
    static func subscribeToTopic(result: @escaping FlutterResult, messageEvent: @escaping FlutterEventSink, subscriptionTopic: String, qos: Int) {
        iotDataManager?.subscribe(toTopic: subscriptionTopic, qoS: qos == 0 ? AWSIoTMQTTQoS.messageDeliveryAttemptedAtMostOnce: AWSIoTMQTTQoS.messageDeliveryAttemptedAtLeastOnce, messageCallback: {
            (payload) -> Void in
            let payloadString = NSString(data: payload, encoding: String.Encoding.utf8.rawValue)!
            messageEvent(["type": "message", "topic": subscriptionTopic, "data": payloadString])
        })
        result(true)
    }
    
    static func publishString(result: @escaping FlutterResult, payload: String, topic: String, qos: Int) {
        iotDataManager?.publishString(payload, onTopic: topic, qoS: qos == 0 ? AWSIoTMQTTQoS.messageDeliveryAttemptedAtMostOnce: AWSIoTMQTTQoS.messageDeliveryAttemptedAtLeastOnce)
        result(true)
    }
}
