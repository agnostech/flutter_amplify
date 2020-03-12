package `in`.agnostech.flutterawsamplifypubsub

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

class getConnectionStabilityTimeFlutterAwsAmplifyPubSubPlugin : FlutterPlugin {

    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_aws_amplify_pubsub/config")
        methodChannel.setMethodCallHandler(PubSubHandler())

        eventChannel = EventChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_aws_amplify_pubsub/sub")
        eventChannel.setStreamHandler(PubSubHandler())
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_aws_amplify_pubsub")
            channel.setMethodCallHandler(PubSubHandler())
            val eventChannel = EventChannel(registrar.messenger(), "flutter_aws_amplify_pubsub/sub")
            eventChannel.setStreamHandler(PubSubHandler())
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }
}
