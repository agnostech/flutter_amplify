package `in`.agnostech.flutter_aws_amplify_pubsub

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


object PubSubHandler: MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

    private lateinit var subscriptionEvent: EventChannel.EventSink

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "initialize" -> FlutterAwsAmplifyPubSub.initialize(result, call.argument<String>("mqttClientId")!!, call.argument<String>("awsIoTEndPointUrl")!!)
            "setMetricsIsEnabled" -> FlutterAwsAmplifyPubSub.setMetricsIsEnabled(result, call.argument<Boolean>("enabled")!!)
            "isMetricsEnabled" -> FlutterAwsAmplifyPubSub.isMetricsEnabled(result)
            "isAutoReconnect" -> FlutterAwsAmplifyPubSub.isAutoReconnect(result)
            "setAutoReconnect" -> FlutterAwsAmplifyPubSub.setAutoReconnect(result, call.argument<Boolean>("autoReconnect")!!)
            "setReconnectRetryLimits" -> FlutterAwsAmplifyPubSub.setReconnectRetryLimits(result, call.argument<Int>("minTimeout")!!, call.argument<Int>("maxTimeout")!!)
            "getMinReconnectRetryTime" -> FlutterAwsAmplifyPubSub.getMinReconnectRetryTime(result)
            "getMaxReconnectRetryTime" -> FlutterAwsAmplifyPubSub.getMaxReconnectRetryTime(result)
            "getMaxAutoReconnectAttempts" -> FlutterAwsAmplifyPubSub.getMaxAutoReconnectAttempts(result)
            "setMaxAutoReconnectAttempts" -> FlutterAwsAmplifyPubSub.setMaxAutoReconnectAttempts(result, call.argument<Int>("attempts")!!)
            "setConnectionStabilityTime" -> FlutterAwsAmplifyPubSub.setConnectionStabilityTime(result, call.argument<Int>("time")!!)
            "getConnectionStabilityTime" -> FlutterAwsAmplifyPubSub.getConnectionStabilityTime(result)
            "isOfflinePublishQueueEnabled" -> FlutterAwsAmplifyPubSub.isOfflinePublishQueueEnabled(result)
            "setOfflinePublishQueueEnabled" -> FlutterAwsAmplifyPubSub.setOfflinePublishQueueEnabled(result, call.argument<Boolean>("queueEnabled")!!)
            "getOfflinePublishQueueBound" -> FlutterAwsAmplifyPubSub.getOfflinePublishQueueBound(result)
            "setOfflinePublishQueueBound" -> FlutterAwsAmplifyPubSub.setOfflinePublishQueueBound(result, call.argument<Int>("bound")!!)
            "getDrainingInterval" -> FlutterAwsAmplifyPubSub.getDrainingInterval(result)
            "setDrainingInterval" -> FlutterAwsAmplifyPubSub.setDrainingInterval(result, call.argument<Long>("interval")!!)
            "fullPublishQueueKeepsOldestMessages" -> FlutterAwsAmplifyPubSub.fullPublishQueueKeepsOldestMessages(result)
            "setFullQueueToKeepOldestMessages" -> FlutterAwsAmplifyPubSub.setFullQueueToKeepOldestMessages(result)
            "setFullQueueToKeepNewestMessages" -> FlutterAwsAmplifyPubSub.setFullQueueToKeepNewestMessages(result)
            "getKeepAlive" -> FlutterAwsAmplifyPubSub.getKeepAlive(result)
            "setKeepAlive" -> FlutterAwsAmplifyPubSub.setKeepAlive(result, call.argument<Int>("keepAlive")!!)
            "getMqttLastWillAndTestament" -> FlutterAwsAmplifyPubSub.getMqttLastWillAndTestament(result)
            "setMqttLastWillAndTestament" -> FlutterAwsAmplifyPubSub.setMqttLastWillAndTestament(result, call.argument<Int>("qos")!!, call.argument<String>("message")!!, call.argument<String>("topic")!!)
            "setAutoResubscribe" -> FlutterAwsAmplifyPubSub.setAutoResubscribe(result, call.argument<Boolean>("enabled")!!)
            "setCleanSession" -> FlutterAwsAmplifyPubSub.setCleanSession(result, call.argument<Boolean>("cleanSession")!!)
            "connect" -> FlutterAwsAmplifyPubSub.connect(result, subscriptionEvent)
            "disconnect" -> FlutterAwsAmplifyPubSub.disconnect(result)
            "subscribeToTopic" -> FlutterAwsAmplifyPubSub.subscribeToTopic(result, subscriptionEvent, call.argument<String>("subscriptionTopic")!!, call.argument<Int>("qos")!!)
            "unsubscribeTopic" -> FlutterAwsAmplifyPubSub.unsubscribeTopic(result, call.argument<String>("topic")!!)
            "attachPolicy" -> FlutterAwsAmplifyPubSub.attachPolicy(result, call.argument<String>("policyName")!!, call.argument<String>("awsRegion")!!)
            "publishString" -> FlutterAwsAmplifyPubSub.publishString(result, call.argument<String>("payload")!!, call.argument<String>("topic")!!, call.argument<Int>("qos")!!)
        }
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
        subscriptionEvent = events
    }

    override fun onCancel(arguments: Any?) {

    }

}