//
//  CognitoUserStatusReceiver.swift
//  flutter_aws_amplify_cognito
//
//  Created by Vishal Dubey on 08/03/20.
//

import Foundation
import AWSMobileClient

class CognitoUserStatusReceiver: NSObject, FlutterStreamHandler {
    
    
    func onListen(withArguments arguments: Any?, eventSink event: @escaping FlutterEventSink) -> FlutterError? {
        AWSMobileClient.default().addUserStateListener(self) { (userState, _) in
            switch (userState) {
            case .guest:
                event("GUEST")
            case .signedOut:
                event("SIGNED_OUT")
            case .signedIn:
                event("SIGNED_IN")
            case .signedOutUserPoolsTokenInvalid:
                event("SIGNED_OUT_USER_POOLS_TOKENS_INVALID")
            case .signedOutFederatedTokensInvalid:
                event("SIGNED_OUT_FEDERATED_TOKENS_INVALID")
            case .unknown:
                event("UNKNOWN")
            default:
                event("ERROR")
            }
        }
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        AWSMobileClient.default().removeUserStateListener(self)
        return nil
    }
}
