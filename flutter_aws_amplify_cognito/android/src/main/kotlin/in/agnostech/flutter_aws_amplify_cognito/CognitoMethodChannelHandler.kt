package `in`.agnostech.flutter_aws_amplify_cognito

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class CognitoMethodChannelHandler(private val context: Context) : MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "isSignedIn" -> result.success(FlutterAwsAmplifyCognito.isSignedIn())
            "currentUserState" -> result.success(FlutterAwsAmplifyCognito.currentUserState())
            "initialize" -> FlutterAwsAmplifyCognito.initialize(context, result)
            "signOut" -> FlutterAwsAmplifyCognito.signOut()
            "signOutGlobally" -> FlutterAwsAmplifyCognito.signOutGlobally(result)
            "getUserAttributes" -> FlutterAwsAmplifyCognito.getUserAttributes(result)
            "getUsername" -> result.success(FlutterAwsAmplifyCognito.getUsername())
            "getIdentityId" -> result.success(FlutterAwsAmplifyCognito.getIdentityId())
            "getTokens" -> FlutterAwsAmplifyCognito.getTokens(result)
            "getIdToken" -> result.success(FlutterAwsAmplifyCognito.getIdToken())
            "getAccessToken" -> result.success(FlutterAwsAmplifyCognito.getAccessToken())
            "getRefreshToken" -> result.success(FlutterAwsAmplifyCognito.getRefreshToken())
            "getCredentials" -> FlutterAwsAmplifyCognito.getCredentials(result)
            "trackDevice" -> FlutterAwsAmplifyCognito.trackDevice(result)
            "untrackDevice" -> FlutterAwsAmplifyCognito.untrackDevice(result)
            "forgetDevice" -> FlutterAwsAmplifyCognito.forgetDevice(result)
            "getDeviceDetails" -> FlutterAwsAmplifyCognito.getDeviceDetails(result)
            "signUp" -> FlutterAwsAmplifyCognito.signUp(
                    result, call.argument<String>("username")!!,
                    call.argument<String>("password")!!,
                    call.argument<Map<String, String>>("userAttributes")!!
            )
            "confirmSignUp" -> FlutterAwsAmplifyCognito.confirmSignUp(
                    result,
                    call.argument<String>("username")!!,
                    call.argument<String>("code")!!
            )
            "resendSignUp" -> FlutterAwsAmplifyCognito.resendSignUp(
                    result,
                    call.argument<String>("username")!!
            )
            "signIn" -> FlutterAwsAmplifyCognito.signIn(
                    result,
                    call.argument<String>("username")!!,
                    call.argument<String>("password")!!
            )
            "confirmSignIn" -> FlutterAwsAmplifyCognito.confirmSignIn(
                    result,
                    call.argument<String>("confirmSignInChallenge")!!
            )
            "forgotPassword" -> FlutterAwsAmplifyCognito.forgotPassword(
                    result,
                    call.argument<String>("username")!!
            )
            "confirmForgotPassword" -> FlutterAwsAmplifyCognito.confirmForgotPassword(
                    result,
                    call.argument<String>("newPassword")!!,
                    call.argument<String>("confirmationCode")!!

            )
            "federatedSignIn" -> FlutterAwsAmplifyCognito.federatedSignIn(
                    result,
                    call.argument<String>("identityProvider")!!,
                    call.argument<String>("token")!!,
                    call.argument<String>("customRoleARN"),
                    call.argument<String>("cognitoIdentityId")
            )
            else -> result.notImplemented()
        }
    }

}