package `in`.agnostech.flutter_aws_amplify_cognito

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar


class FlutterAwsAmplifyCognitoPlugin : FlutterPlugin {

    private lateinit var methodChannel: MethodChannel
    private lateinit var userStatusChannel: EventChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_aws_amplify_cognito/cognito")
        methodChannel.setMethodCallHandler(CognitoMethodChannelHandler(flutterPluginBinding.applicationContext))

        userStatusChannel = EventChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_aws_amplify_cognito/cognito_user_status")
        userStatusChannel.setStreamHandler(CognitoUserStatusReceiver())
    }


    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val methodChannel = MethodChannel(registrar.messenger(), "flutter_aws_amplify_cognito/cognito")
            methodChannel.setMethodCallHandler(CognitoMethodChannelHandler(registrar.context()))

            val eventChannel = EventChannel(registrar.messenger(), "flutter_aws_amplify_cognito/cognito_user_status")
            eventChannel.setStreamHandler(CognitoUserStatusReceiver())

        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        userStatusChannel.setStreamHandler(null)
    }
}
