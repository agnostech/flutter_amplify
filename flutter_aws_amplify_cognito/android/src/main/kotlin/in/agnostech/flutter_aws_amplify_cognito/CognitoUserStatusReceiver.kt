package `in`.agnostech.flutter_aws_amplify_cognito

import io.flutter.plugin.common.EventChannel
import com.amazonaws.mobile.client.AWSMobileClient
import com.amazonaws.mobile.client.UserStateListener

class CognitoUserStatusReceiver: EventChannel.StreamHandler {

    private lateinit var userStateListener: UserStateListener

    override fun onListen(arguments: Any?, event: EventChannel.EventSink) {
        userStateListener = UserStateListener {
            event.success(it.userState.name)
        }
        AWSMobileClient.getInstance().addUserStateListener(userStateListener)
    }

    override fun onCancel(arguments: Any?) {
        AWSMobileClient.getInstance().removeUserStateListener(userStateListener)
    }

}