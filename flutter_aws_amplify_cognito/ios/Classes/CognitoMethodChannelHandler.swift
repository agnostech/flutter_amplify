//
//  CognitoMethodChannelHandler.swift
//  flutter_aws_amplify_cognito
//
//  Created by Vishal Dubey on 09/03/20.
//

import Foundation
import Flutter

func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let arguments: [String: Any] = call.arguments as? [String : Any] else {
        result("Could not unwrap Flutter arguments")
        return
    }
    switch call.method {
    case "isSignedIn":
        result(SwiftFlutterAwsAmplifyCognito.isSignedIn())
        
    case "currentUserState":
        result(SwiftFlutterAwsAmplifyCognito.currentUserState())
        
    case "initialize":
        SwiftFlutterAwsAmplifyCognito.initialize(result: result)
        
    case "signOut":
        SwiftFlutterAwsAmplifyCognito.signOut()
        
    case "signOutGlobally":
        SwiftFlutterAwsAmplifyCognito.signOutGlobally(result: result)
        
    case "getUserAttributes":
        SwiftFlutterAwsAmplifyCognito.getUserAttributes(result: result)
        
    case "getUsername":
        result(SwiftFlutterAwsAmplifyCognito.getUsername())
        
    case "getIdentityId":
        result(SwiftFlutterAwsAmplifyCognito.getIdentityId())
        
    case "getTokens":
        SwiftFlutterAwsAmplifyCognito.getTokens(result: result)
        
    case "getIdToken":
        SwiftFlutterAwsAmplifyCognito.getIdToken(result: result)
        
    case "getAccessToken":
        SwiftFlutterAwsAmplifyCognito.getAccesstoken(result: result)
        
    case "getRefreshToken":
        SwiftFlutterAwsAmplifyCognito.getRefreshToken(result: result)
        
    case "getCredentials":
        SwiftFlutterAwsAmplifyCognito.getCredentials(result: result)
        
    case "trackDevice":
        SwiftFlutterAwsAmplifyCognito.trackDevice(result: result)
        
    case "untrackDevice":
        SwiftFlutterAwsAmplifyCognito.untrackDevice(result: result)
        
    case "forgetDevice":
        SwiftFlutterAwsAmplifyCognito.forgetDevice(result: result)
        
    case "getDeviceDetails":
        SwiftFlutterAwsAmplifyCognito.getDeviceDetails(result: result)
        
    case "signUp":
        SwiftFlutterAwsAmplifyCognito.signUp(result: result, username: arguments["username"] as! String, password: arguments["password"] as! String, userAttributes: arguments["userAttributes"] as! [String : String])
        
    case "confirmSignUp":
        SwiftFlutterAwsAmplifyCognito.confirmSignUp(result: result, username: arguments["username"] as! String, code: arguments["code"] as! String)
        
    case "resendSignUp":
        SwiftFlutterAwsAmplifyCognito.resendSignUp(result: result, username: arguments["username"] as! String)
        
    case "signIn":
        SwiftFlutterAwsAmplifyCognito.signIn(result: result, username: arguments["username"] as! String, password: arguments["password"] as! String)
        
    case "confirmSignIn":
        SwiftFlutterAwsAmplifyCognito.confirmSignIn(result: result, confirmSignInChallenge: arguments["confirmSignInChallenge"] as! String)
        
    case "forgotPassword":
        SwiftFlutterAwsAmplifyCognito.forgotPassword(result: result, username: arguments["username"] as! String)
        
    case "confirmForgotPassword":
        SwiftFlutterAwsAmplifyCognito.confirmForgotPassword(result: result, username: arguments["username"] as! String, newPassword: arguments["newPassword"] as! String, confirmationCode: arguments["confirmationCode"] as! String)
        
    default:
        result(FlutterMethodNotImplemented)
    }
}
