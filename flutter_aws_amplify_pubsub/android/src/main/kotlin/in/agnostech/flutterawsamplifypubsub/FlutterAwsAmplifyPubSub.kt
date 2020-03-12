package `in`.agnostech.flutterawsamplifypubsub

import com.amazonaws.mobileconnectors.iot.AWSIotMqttManager
import com.amazonaws.regions.Region
import com.amazonaws.regions.Regions
import io.flutter.plugin.common.MethodChannel
import kotlin.math.min

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


    }
}