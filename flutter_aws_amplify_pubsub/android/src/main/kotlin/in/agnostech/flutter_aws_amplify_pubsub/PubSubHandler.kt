package `in`.agnostech.flutter_aws_amplify_pubsub

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class PubSubHandler: MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

    private lateinit var subscriptionEvent: EventChannel.EventSink

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "initialize" -> ""
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
        subscriptionEvent = events
    }

    override fun onCancel(arguments: Any?) {

    }

}