import 'package:flutter/services.dart';
import 'package:flutter_aws_amplify_pubsub/common/connection_status.dart';
import 'package:flutter_aws_amplify_pubsub/common/message.dart';
import 'package:flutter_aws_amplify_pubsub/common/utils.dart';
import 'package:flutter_aws_amplify_pubsub/lwt/aws_iot_mqtt_last_will_and_testament.dart';
import 'package:flutter_aws_amplify_pubsub/qos/aws_iot_mqtt_qos.dart';

export 'package:flutter_aws_amplify_pubsub/lwt/aws_iot_mqtt_last_will_and_testament.dart';
export 'package:flutter_aws_amplify_pubsub/qos/aws_iot_mqtt_qos.dart';
export 'package:flutter_aws_amplify_pubsub/common/connection_status.dart';
export 'package:flutter_aws_amplify_pubsub/common/message.dart';

class FlutterAwsAmplifyPubSub {

    static const EventChannel _eventsChannel =
    const EventChannel('flutter_aws_amplify_pubsub/subscriptions');

    static const MethodChannel _methodChannel =
    const MethodChannel('flutter_aws_amplify_pubsub/config');

    static Future<bool> initialize(String mqttClientId,
        String awsIoTEndPointUrl) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['mqttClientId'] = mqttClientId;
            arguments['awsIoTEndPointUrl'] = awsIoTEndPointUrl;
            return await _methodChannel.invokeMethod("initialize", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setMetricsIsEnabled(bool enabled) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['enabled'] = enabled;
            return await _methodChannel.invokeMethod(
                "setMetricsIsEnabled", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> isMetricsEnabled() async {
        try {
            return await _methodChannel.invokeMethod("isMetricsEnabled");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> isAutoReconnect() async {
        try {
            return await _methodChannel.invokeMethod("isAutoReconnect");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setAutoReconnect(bool autoReconnect) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['autoReconnect'] = autoReconnect;
            return await _methodChannel.invokeMethod(
                "setAutoReconnect", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setReconnectRetryLimits(int minTimeout,
        int maxTimeout) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['minTimeout'] = minTimeout;
            arguments['maxTimeout'] = maxTimeout;
            return await _methodChannel.invokeMethod(
                "setReconnectRetryLimits", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<int> getMinReconnectRetryTime() async {
        try {
            return await _methodChannel.invokeMethod(
                "getMinReconnectRetryTime");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<int> getMaxReconnectRetryTime() async {
        try {
            return await _methodChannel.invokeMethod(
                "getMaxReconnectRetryTime");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<int> getMaxAutoReconnectAttempts() async {
        try {
            return await _methodChannel.invokeMethod(
                "getMaxAutoReconnectAttempts");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setMaxAutoReconnectAttempts(int attempts) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['attempts'] = attempts;
            return await _methodChannel.invokeMethod(
                "setMaxAutoReconnectAttempts", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setConnectionStabilityTime(int time) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['time'] = time;
            return await _methodChannel.invokeMethod(
                "setConnectionStabilityTime", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<int> getConnectionStabilityTime() async {
        try {
            return await _methodChannel.invokeMethod(
                "getConnectionStabilityTime");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> isOfflinePublishQueueEnabled() async {
        try {
            return await _methodChannel.invokeMethod(
                "isOfflinePublishQueueEnabled");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setOfflinePublishQueueEnabled(bool queueEnabled) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['queueEnabled'] = queueEnabled;
            return await _methodChannel.invokeMethod(
                "setOfflinePublishQueueEnabled", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<int> getOfflinePublishQueueBound() async {
        try {
            return await _methodChannel.invokeMethod(
                "getOfflinePublishQueueBound");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setOfflinePublishQueueBound(int bound) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['bound'] = bound;
            return await _methodChannel.invokeMethod(
                "setOfflinePublishQueueBound", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<int> getDrainingInterval() async {
        try {
            return await _methodChannel.invokeMethod("getDrainingInterval");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setDrainingInterval(int interval) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['interval'] = interval;
            return await _methodChannel.invokeMethod(
                "setDrainingInterval", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> fullPublishQueueKeepsOldestMessages() async {
        try {
            return await _methodChannel
                .invokeMethod("fullPublishQueueKeepsOldestMessages");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setFullQueueToKeepOldestMessages() async {
        try {
            return await _methodChannel
                .invokeMethod("setFullQueueToKeepOldestMessages");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setFullQueueToKeepNewestMessages() async {
        try {
            return await _methodChannel
                .invokeMethod("setFullQueueToKeepNewestMessages");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<int> getKeepAlive() async {
        try {
            return await _methodChannel.invokeMethod("getKeepAlive");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setKeepAlive(int keepAlive) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['keepAlive'] = keepAlive;
            return await _methodChannel.invokeMethod("setKeepAlive", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<AWSIotMqttLastWillAndTestament>
    getMqttLastWillAndTestament() async {
        try {
            final willData =
            await _methodChannel.invokeMethod("getMqttLastWillAndTestament");
            return AWSIotMqttLastWillAndTestament(
                willData['topic'],
                willData['message'],
                willData['qos'] == 0 ? AWSIotMqttQos.QOS0 : AWSIotMqttQos.QOS1);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setMqttLastWillAndTestament(int qos, String message,
        String topic) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['qos'] = qos;
            arguments['message'] = message;
            arguments['topic'] = topic;
            return await _methodChannel.invokeMethod(
                "setMqttLastWillAndTestament", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setAutoResubscribe(bool enabled) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['enabled'] = enabled;
            return await _methodChannel.invokeMethod(
                "setAutoResubscribe", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> setCleanSession(bool cleanSession) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['cleanSession'] = cleanSession;
            return await _methodChannel.invokeMethod(
                "setCleanSession", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> connect() async {
        try {
            return await _methodChannel.invokeMethod("connect");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> disconnect() async {
        try {
            return await _methodChannel.invokeMethod("disconnect");
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> subscribeToTopic(String subscriptionTopic,
        int qos) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['subscriptionTopic'] = subscriptionTopic;
            arguments['qos'] = qos;
            return await _methodChannel.invokeMethod(
                "subscribeToTopic", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> unsubscribeTopic(String topic) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['topic'] = topic;
            return await _methodChannel.invokeMethod(
                "unsubscribeTopic", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> attachPolicy(String policyName,
        String awsRegion) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['policyName'] = policyName;
            arguments['awsRegion'] = awsRegion;
            return await _methodChannel.invokeMethod("attachPolicy", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Future<bool> publishString(String payload, String topic,
        int qos) async {
        try {
            Map<String, dynamic> arguments = Map<String, dynamic>();
            arguments['topic'] = topic;
            arguments['payload'] = payload;
            arguments['qos'] = qos;
            return await _methodChannel.invokeMethod(
                "publishString", arguments);
        } on PlatformException catch (e) {
            return Future.error(e);
        }
    }

    static Stream<dynamic> get getConnectionStatusAndMessages {
        return _eventsChannel
            .receiveBroadcastStream()
            .map((event) => Map<String, dynamic>.from(event))
            .map((data) {
              if (data['type'] == "connection")
                return parseConnectionStatus(data['status']);
              else return parseMqttMessage(data);
        });
    }
}
