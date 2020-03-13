//
//  PubSubHandler.swift
//  flutterawsamplifypubsub
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
        
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventChannel = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        
        return nil
    }
    
}
