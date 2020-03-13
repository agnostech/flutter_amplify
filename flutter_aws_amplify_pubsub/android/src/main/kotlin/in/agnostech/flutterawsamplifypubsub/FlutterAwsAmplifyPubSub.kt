package `in`.agnostech.flutterawsamplifypubsub

import com.amazonaws.mobile.client.AWSMobileClient
import com.amazonaws.mobileconnectors.iot.*
import com.amazonaws.regions.Region
import com.amazonaws.services.iot.AWSIotClient
import com.amazonaws.services.iot.model.AttachPolicyRequest
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class FlutterAwsAmplifyPubSub {

    companion object {
        private lateinit var awsIotManager: AWSIotMqttManager

        fun initialize(result: MethodChannel.Result, mqttClientId: String, awsIoTEndPointUrl: String) {
            try {
                awsIotManager = AWSIotMqttManager(
                        mqttClientId, awsIoTEndPointUrl
                )
                result.success(true)
            } catch (e: Error) {
                result.error("Error", "Error initializing AWSIoTMqttManager", e.localizedMessage)
            }
        }

        fun setMetricsIsEnabled(result: MethodChannel.Result, enabled: Boolean) {
            try {
                awsIotManager.setMetricsIsEnabled(enabled)
                result.success(true)
            } catch (e: Error) {
                result.error("Error", "Error enabling metrics", e.localizedMessage)
            }
        }

        fun isMetricsEnabled(result: MethodChannel.Result) = result.success(awsIotManager.isMetricsEnabled)

        fun isAutoReconnect(result: MethodChannel.Result) = result.success(awsIotManager.isAutoReconnect)

        fun setAutoReconnect(result: MethodChannel.Result, autoReconnect: Boolean) {
            awsIotManager.isAutoReconnect = autoReconnect
        }

        fun setReconnectRetryLimits(result: MethodChannel.Result, minTimeout: Int, maxTimeout: Int) {
            try {
                awsIotManager.setReconnectRetryLimits(minTimeout, maxTimeout)
            } catch (e: Error) {
                result.error("Error", "Error changing reconnect retry limits", e.localizedMessage)
            }
        }

        fun getMinReconnectRetryTime(result: MethodChannel.Result) = result.success(awsIotManager.minReconnectRetryTime)

        fun getMaxReconnectRetryTime(result: MethodChannel.Result) = result.success(awsIotManager.maxReconnectRetryTime)

        fun getMaxAutoReconnectAttempts(result: MethodChannel.Result) = result.success(awsIotManager.maxAutoReconnectAttempts)

        fun setMaxAutoReconnectAttempts(result: MethodChannel.Result, attempts: Int) {
            try {
                awsIotManager.maxAutoReconnectAttempts = attempts
            } catch (e: Error) {
                result.error("Error", "Error changing max auto reconnect attempts", e.localizedMessage)
            }
        }

        fun setConnectionStabilityTime(result: MethodChannel.Result, time: Int) {
            try {
                awsIotManager.connectionStabilityTime = time
            } catch (e: Error) {
                result.error("Error", "Error setting connection stability time", e.localizedMessage)
            }
        }

        fun getConnectionStabilityTime(result: MethodChannel.Result) = result.success(awsIotManager.connectionStabilityTime)

        fun isOfflinePublishQueueEnabled(result: MethodChannel.Result) = result.success(awsIotManager.isOfflinePublishQueueEnabled)

        fun setOfflinePublishQueueEnabled(result: MethodChannel.Result, queueEnabled: Boolean) {
            try {
                awsIotManager.isOfflinePublishQueueEnabled = queueEnabled
                result.success(true)
            } catch (e: Error) {
                result.error("Error", "Error enabling offline queue", e.localizedMessage)
            }
        }

        fun getOfflinePublishQueueBound(result: MethodChannel.Result) = result.success(awsIotManager.offlinePublishQueueBound)

        fun setOfflinePublishQueueBound(result: MethodChannel.Result, bound: Int) {
            try {
                awsIotManager.offlinePublishQueueBound = bound
            } catch (e: Error) {
                result.error("Error", "Error setting offline publish queue bond", e.localizedMessage)
            }
        }

        fun getDrainingInterval(result: MethodChannel.Result) = result.success(awsIotManager.drainingInterval)

        fun setDrainingInterval(result: MethodChannel.Result, interval: Long) {
            try {
                awsIotManager.drainingInterval = interval
            } catch (e: Error) {
                result.error("Error", "Error setting draining interval", e.localizedMessage)
            }
        }

        fun fullPublishQueueKeepsOldestMessages(result: MethodChannel.Result) = result.success(awsIotManager.fullPublishQueueKeepsOldestMessages())

        fun setFullQueueToKeepOldestMessages(result: MethodChannel.Result) {
            try {
                awsIotManager.setFullQueueToKeepOldestMessages()
                result.success(true)
            } catch (e: Error) {
                result.error("Error", "Error setting queue for old messages", e.localizedMessage)
            }
        }

        fun setFullQueueToKeepNewestMessages(result: MethodChannel.Result) {
            try {
                awsIotManager.setFullQueueToKeepNewestMessages()
                result.success(true)
            } catch (e: Error) {
                result.error("Error", "Error", e.localizedMessage)
            }
        }

        fun getKeepAlive(result: MethodChannel.Result) = result.success(awsIotManager.keepAlive)

        fun setKeepAlive(result: MethodChannel.Result, keepAlive: Int) {
            try {
                awsIotManager.keepAlive = keepAlive
                result.success(true)
            } catch (e: Error) {
                result.error("Error", "Error", e.localizedMessage)
            }
        }

        fun getMqttLastWillAndTestament(result: MethodChannel.Result) {
            val lastWill = awsIotManager.mqttLastWillAndTestament
            result.success(hashMapOf(
                    "message" to lastWill.message,
                    "topic" to lastWill.topic,
                    "qos" to lastWill.qos
            ))
        }

        fun setMqttLastWillAndTestament(result: MethodChannel.Result, qos: Int, message: String, topic: String) {
            try {
                awsIotManager.mqttLastWillAndTestament = AWSIotMqttLastWillAndTestament(
                        topic, message, if (qos == 0) AWSIotMqttQos.QOS0 else AWSIotMqttQos.QOS1
                )
                result.success(true)
            } catch (e: Error) {
                result.error("Error", "Error", e.localizedMessage)
            }
        }

        fun setAutoResubscribe(result: MethodChannel.Result, enabled: Boolean) {
            try {
                awsIotManager.setAutoResubscribe(enabled)
                result.success(true)
            } catch (e: Error) {
                result.error("Error", "Error", e.localizedMessage)
            }
        }

        fun setCleanSession(result: MethodChannel.Result, cleanSession: Boolean) {
            try {
                awsIotManager.setCleanSession(cleanSession)
                result.success(true)
            } catch (e: Error) {
                result.error("Error", "Error", e.localizedMessage)
            }
        }

        fun connect(result: MethodChannel.Result, connectEvent: EventChannel.EventSink) {
            try {
                awsIotManager.connect(AWSMobileClient.getInstance()) { status, throwable ->
                    if (throwable != null) {
                        connectEvent.error("Error", "Error connecting", throwable.localizedMessage)
                    }
                    connectEvent.success(status.name)
                }
                result.success(true)
            } catch (e: Error) {
                result.error("Error", "Error", e.localizedMessage)
            }
        }

        fun disconnect(result: MethodChannel.Result) {
            try {
                awsIotManager.disconnect()
                result.success(true)
            } catch (e: Error) {
                result.error("Error", "Error disconnecting", e.localizedMessage)
            }
        }

        fun subscribeToTopic(result: MethodChannel.Result, messageEvent: EventChannel.EventSink, subscriptionTopic: String, qos: Int) {
            try {
                awsIotManager.subscribeToTopic(subscriptionTopic, if (qos == 0) AWSIotMqttQos.QOS0 else AWSIotMqttQos.QOS1, object : AWSIotMqttSubscriptionStatusCallback {
                    override fun onSuccess() {
                        result.success(true)
                    }

                    override fun onFailure(exception: Throwable) {
                        result.error("Error", "Error subscribing to $subscriptionTopic", exception.localizedMessage)
                    }

                }) { topic, data ->
                    messageEvent.success(hashMapOf(
                            "topic" to topic,
                            "data" to String(data, Charsets.UTF_8)
                    ))
                }
                result.success(true)
            } catch (e: Error) {
                result.error("Error", "Error", e.localizedMessage)
            }
        }

        fun unsubscribeTopic(result: MethodChannel.Result, topic: String) {
            try {
                awsIotManager.unsubscribeTopic(topic)
                result.success(true)
            } catch(e: Error) {
                result.error("Error", "Error", e.localizedMessage)
            }
        }

        fun attachPolicy(result: MethodChannel.Result, policyName: String, awsRegion: String) {
            try {
                val attachPolicyReq = AttachPolicyRequest()
                attachPolicyReq.policyName = policyName
                attachPolicyReq.target = AWSMobileClient.getInstance().identityId
                val iotAndroidClient = AWSIotClient(AWSMobileClient.getInstance())
                iotAndroidClient.setRegion(Region.getRegion(awsRegion))
                iotAndroidClient.attachPolicy(attachPolicyReq)
                result.success(true)
            } catch(e: Error) {
                result.error("Error", "Error attaching policy", e.localizedMessage)
            }
        }

        fun publishString(result: MethodChannel.Result, payload: String, topic: String, qos: Int) {
            try {
                awsIotManager.publishString(payload, topic, if (qos == 0) AWSIotMqttQos.QOS0 else AWSIotMqttQos.QOS1)
                result.success(true)
            } catch(e: Error) {
                result.error("Error", "Error", e.localizedMessage)
            }
        }

    }
}