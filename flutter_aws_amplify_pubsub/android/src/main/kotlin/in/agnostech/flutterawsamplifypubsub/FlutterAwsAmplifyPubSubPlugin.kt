package `in`.agnostech.flutterawsamplifypubsub

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterAwsAmplifyPubSubPlugin : FlutterPlugin {

    private lateinit var methodChannel: MethodChannel
    private lateinit var subsChannel: EventChannel
    private lateinit var connectionChannel: EventChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "flutter_aws_amplify_pubsub/config")
        methodChannel.setMethodCallHandler(PubSubHandler())

        subsChannel = EventChannel(flutterPluginBinding.flutterEngine.dartExecutor, "flutter_aws_amplify_pubsub/sub")
        subsChannel.setStreamHandler(PubSubHandler())

        connectionChannel = EventChannel(flutterPluginBinding.flutterEngine.dartExecutor, "flutter_aws_amplify_pubsub/pubsub_conn")
        connectionChannel.setStreamHandler(PubSubHandler())
    }

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_aws_amplify_pubsub")
            channel.setMethodCallHandler(PubSubHandler())
            val subsChannel = EventChannel(registrar.messenger(), "flutter_aws_amplify_pubsub/sub")
            subsChannel.setStreamHandler(PubSubHandler())
            val connectionChannel = EventChannel(registrar.messenger(), "flutter_aws_amplify_pubsub/pubsub_conn")
            connectionChannel.setStreamHandler(PubSubHandler())
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        subsChannel.setStreamHandler(null)
        connectionChannel.setStreamHandler(null)
    }
}
