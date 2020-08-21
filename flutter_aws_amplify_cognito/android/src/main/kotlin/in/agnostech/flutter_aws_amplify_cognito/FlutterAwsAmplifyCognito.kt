package `in`.agnostech.flutter_aws_amplify_cognito

import android.content.Context
import android.os.Handler
import android.os.Looper
import com.amazonaws.auth.AWSCredentials
import com.amazonaws.mobile.client.*
import com.amazonaws.mobile.client.results.*
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.lang.Exception

class FlutterAwsAmplifyCognito {
    companion object {
        fun isSignedIn() = AWSMobileClient.getInstance().isSignedIn
        fun currentUserState(result: MethodChannel.Result) =
                AWSMobileClient.getInstance().currentUserState(object: Callback<UserStateDetails> {
                    override fun onResult(details: UserStateDetails) {
                        Handler(Looper.getMainLooper()).post {
                            result.success(details.userState.name)
                        }
                    }

                    override fun onError(e: Exception) {
                        Handler(Looper.getMainLooper()).post {
                            result.error("Error", "Error getting current user state", e.localizedMessage)
                        }
                    }

                })
        fun initialize(context: Context, result: MethodChannel.Result) =
                AWSMobileClient.getInstance().initialize(context, object : Callback<UserStateDetails> {
                    override fun onResult(userStateDetails: UserStateDetails) {
                        Handler(Looper.getMainLooper()).post {
                            result.success(userStateDetails.userState.name)
                        }
                    }

                    override fun onError(e: Exception) {
                        Handler(Looper.getMainLooper()).post {
                            result.error("Error", "Error fetching user details",  e.localizedMessage)
                        }
                    }
                })

        fun signOut(result: MethodChannel.Result) = AWSMobileClient.getInstance().signOut(
                SignOutOptions.builder().signOutGlobally(false).build(),
                object : Callback<Void> {
                    override fun onResult(signOutResult: Void?) {
                        Handler(Looper.getMainLooper()).post {
                            result.success(true)
                        }
                    }

                    override fun onError(e: Exception) {
                        Handler(Looper.getMainLooper()).post {
                            result.error("Error", "Error signing in", e.localizedMessage)
                        }
                    }
                }
        )
        fun signOutGlobally(result: MethodChannel.Result) = AWSMobileClient.getInstance().signOut(
                SignOutOptions.builder().signOutGlobally(true).build(),
                object : Callback<Void> {
                    override fun onResult(signOutResult: Void?) {
                        Handler(Looper.getMainLooper()).post {
                            result.success(true)
                        }
                    }

                    override fun onError(e: Exception) {
                        Handler(Looper.getMainLooper()).post {
                            result.error("Error", "Error signing in", e.localizedMessage)
                        }
                    }

                }
        )

        fun getUserAttributes(result: MethodChannel.Result) =
                AWSMobileClient.getInstance().getUserAttributes(object : Callback<Map<String, String>> {
                    override fun onResult(userAttributes: Map<String, String>) {
                        Handler(Looper.getMainLooper()).post {
                            result.success(userAttributes)
                        }
                    }

                    override fun onError(e: Exception) {
                        Handler(Looper.getMainLooper()).post {
                            result.error("Error", "Error getting user attributes", e.localizedMessage)
                        }
                    }

                })

        fun getUsername(result: MethodChannel.Result) {
            try {
                val username = AWSMobileClient.getInstance().username;
                result.success(username)
            } catch (e: Error) {
                result.error("Error", "Error getting username", e.localizedMessage)
            }
        }
        fun getIdentityId(result: MethodChannel.Result) {
            try {
                val identityId = AWSMobileClient.getInstance().identityId
                result.success(identityId)
            } catch (e: Error) {
                result.error("Error", "Error getting Identity ID", e.localizedMessage)
            }
        }
        fun getTokens(result: MethodChannel.Result) = AWSMobileClient.getInstance().getTokens(object : Callback<Tokens> {
            override fun onResult(tokens: Tokens) {
                Handler(Looper.getMainLooper()).post {
                    // TODO: pass all the token details
                    result.success(hashMapOf(
                            "accessToken" to tokens.accessToken.tokenString,
                            "idToken" to tokens.idToken.tokenString,
                            "refreshToken" to tokens.refreshToken.tokenString
                    ))
                }
            }

            override fun onError(e: Exception) {
                Handler(Looper.getMainLooper()).post {
                    result.error("Error", "Error getting tokens", e.localizedMessage)
                }
            }

        })

        fun getIdToken(result: MethodChannel.Result) {
            GlobalScope.launch(Dispatchers.Default) {
                try {
                    val idToken = AWSMobileClient.getInstance().tokens.idToken.tokenString
                    Handler(Looper.getMainLooper()).post {
                        result.success(idToken)
                    }
                } catch (e: Error) {
                    Handler(Looper.getMainLooper()).post {
                        result.error("Error", "Error getting ID Token", e.localizedMessage)
                    }
                }
            }
        }

        fun getAccessToken(result: MethodChannel.Result) {
            GlobalScope.launch(Dispatchers.Default) {
                try {
                    val accessToken = AWSMobileClient.getInstance().tokens.accessToken.tokenString
                    Handler(Looper.getMainLooper()).post {
                        result.success(accessToken)
                    }
                } catch (e: Error) {
                    Handler(Looper.getMainLooper()).post {
                        result.error("Error", "Error getting Access Token", e.localizedMessage)
                    }
                }
            }
        }

        fun getRefreshToken(result: MethodChannel.Result){
            GlobalScope.launch(Dispatchers.Default) {
                try {
                    val refreshToken = AWSMobileClient.getInstance().tokens.refreshToken.tokenString
                    Handler(Looper.getMainLooper()).post {
                        result.success(refreshToken)
                    }
                } catch (e: Error) {
                    Handler(Looper.getMainLooper()).post {
                        result.error("Error", "Error getting Refresh Token", e.localizedMessage)
                    }
                }
            }
        }

        fun getCredentials(result: MethodChannel.Result) {
            AWSMobileClient.getInstance().getAWSCredentials(object: Callback<AWSCredentials> {
                override fun onResult(credentials: AWSCredentials) {
                    Handler(Looper.getMainLooper()).post {
                        result.success(hashMapOf(
                                "secretKey" to credentials.awsSecretKey,
                                "accessKeyId" to credentials.awsAccessKeyId
                        ))
                    }
                }

                override fun onError(e: Exception) {
                    Handler(Looper.getMainLooper()).post {
                        result.error("Error", "Error getting credentials", e.localizedMessage)
                    }
                }

            })
        }

        fun signUp(result: MethodChannel.Result, username: String, password: String, userAttributes: Map<String, String>) =
                AWSMobileClient.getInstance().signUp(
                        username, password, userAttributes,
                        null,
                        object : Callback<SignUpResult> {
                            override fun onResult(signUpResult: SignUpResult) {
                                if (signUpResult.confirmationState) {
                                    Handler(Looper.getMainLooper()).post {
                                        result.success(hashMapOf(
                                                "confirmationState" to true,
                                                "destination" to "",
                                                "deliveryMedium" to "",
                                                "attributeName" to ""
                                        ))
                                    }
                                } else {
                                    val userCodeDeliveryDetails = signUpResult.userCodeDeliveryDetails;
                                    Handler(Looper.getMainLooper()).post {
                                        result.success(hashMapOf(
                                                "confirmationState" to false,
                                                "destination" to userCodeDeliveryDetails?.destination,
                                                "deliveryMedium" to userCodeDeliveryDetails?.deliveryMedium,
                                                "attributeName" to userCodeDeliveryDetails?.attributeName

                                        ))
                                    }
                                }
                            }

                            override fun onError(e: Exception) {
                                Handler(Looper.getMainLooper()).post {
                                    result.error("Error", "Error signing up", e.localizedMessage)
                                }
                            }

                        }
                )

        fun confirmSignUp(result: MethodChannel.Result, username: String, code: String) =
                AWSMobileClient.getInstance().confirmSignUp(
                        username, code,
                        object : Callback<SignUpResult> {
                            override fun onResult(signUpResult: SignUpResult) {
                                if (signUpResult.confirmationState) {
                                    Handler(Looper.getMainLooper()).post {
                                        result.success(hashMapOf(
                                                "confirmationState" to true,
                                                "destination" to "",
                                                "deliveryMedium" to "",
                                                "attributeName" to ""
                                        ))
                                    }
                                } else {
                                    val userCodeDeliveryDetails = signUpResult.userCodeDeliveryDetails;
                                    Handler(Looper.getMainLooper()).post {
                                        result.success(hashMapOf(
                                                "confirmationState" to false,
                                                "destination" to userCodeDeliveryDetails?.destination,
                                                "deliveryMedium" to userCodeDeliveryDetails?.deliveryMedium,
                                                "attributeName" to userCodeDeliveryDetails?.attributeName

                                        ))
                                    }
                                }
                            }

                            override fun onError(e: Exception) {
                                Handler(Looper.getMainLooper()).post {
                                    result.error("Error", "Error signing up", e.localizedMessage)
                                }
                            }

                        }
                )

        fun resendSignUp(result: MethodChannel.Result, username: String) =
                AWSMobileClient.getInstance().resendSignUp(
                        username,
                        object : Callback<SignUpResult> {
                            override fun onResult(signUpResult: SignUpResult) {
                                val userCodeDeliveryDetails = signUpResult.userCodeDeliveryDetails;
                                Handler(Looper.getMainLooper()).post {
                                    result.success(hashMapOf(
                                            "confirmationState" to signUpResult.confirmationState,
                                            "destination" to userCodeDeliveryDetails?.destination,
                                            "deliveryMedium" to userCodeDeliveryDetails?.deliveryMedium,
                                            "attributeName" to userCodeDeliveryDetails?.attributeName
                                    ))
                                }
                            }

                            override fun onError(e: Exception) {
                                Handler(Looper.getMainLooper()).post {
                                    result.error("Error", "Error confirming signing up", e.localizedMessage)
                                }
                            }

                        }
                )

        fun signIn(result: MethodChannel.Result, username: String, password: String) =
                AWSMobileClient.getInstance().signIn(
                        username,
                        password,
                        null,
                        object : Callback<SignInResult> {
                            override fun onResult(signInResult: SignInResult) {
                                val userCodeDeliveryDetails = signInResult.codeDetails
                                Handler(Looper.getMainLooper()).post {
                                    result.success(hashMapOf(
                                            "signInState" to signInResult.signInState.name,
                                            "parameters" to signInResult.parameters,
                                            "destination" to userCodeDeliveryDetails?.destination,
                                            "deliveryMedium" to userCodeDeliveryDetails?.deliveryMedium ,
                                            "attributeName" to userCodeDeliveryDetails?.attributeName
                                    ))
                                }
                            }

                            override fun onError(e: Exception) {
                                Handler(Looper.getMainLooper()).post {
                                    result.error("Error", "Error signing in", e.localizedMessage)
                                }
                            }

                        }
                )

        fun confirmSignIn(result: MethodChannel.Result, confirmSignInChallenge: String) =
                AWSMobileClient.getInstance().confirmSignIn(
                        confirmSignInChallenge,
                        object : Callback<SignInResult> {
                            override fun onResult(signInResult: SignInResult) {
                                val userCodeDeliveryDetails = signInResult.codeDetails
                                Handler(Looper.getMainLooper()).post {
                                    result.success(hashMapOf(
                                            "signInState" to signInResult.signInState.name,
                                            "parameters" to signInResult.parameters,
                                            "destination" to userCodeDeliveryDetails?.destination,
                                            "deliveryMedium" to userCodeDeliveryDetails?.deliveryMedium,
                                            "attributeName" to userCodeDeliveryDetails?.attributeName

                                    ))
                                }
                            }

                            override fun onError(e: Exception) {
                                Handler(Looper.getMainLooper()).post {
                                    result.error("Error", "Error signing in", e.localizedMessage)
                                }
                            }

                        }
                )

        fun forgotPassword(result: MethodChannel.Result, username: String) =
                AWSMobileClient.getInstance().forgotPassword(
                        username,
                        object : Callback<ForgotPasswordResult> {
                            override fun onResult(forgotPasswordResult: ForgotPasswordResult) {
                                Handler(Looper.getMainLooper()).post {
                                    val userCodeDeliveryDetails = forgotPasswordResult.parameters;
                                    result.success(hashMapOf(
                                            "destination" to userCodeDeliveryDetails?.destination,
                                            "deliveryMedium" to userCodeDeliveryDetails?.deliveryMedium,
                                            "attributeName" to userCodeDeliveryDetails?.attributeName,
                                            "state" to forgotPasswordResult.state.name
                                    ))
                                }
                            }

                            override fun onError(e: Exception) {
                                Handler(Looper.getMainLooper()).post {
                                    result.error("Error", "Error requesting password reset", e.localizedMessage)
                                }
                            }
                        }
                )

        fun confirmForgotPassword(result: MethodChannel.Result,
                                  newPassword: String,
                                  confirmationCode: String) =
                AWSMobileClient.getInstance().confirmForgotPassword(
                        newPassword, confirmationCode,
                        object : Callback<ForgotPasswordResult> {
                            override fun onResult(forgotPasswordResult: ForgotPasswordResult) {
                                Handler(Looper.getMainLooper()).post {
                                    val userCodeDeliveryDetails = forgotPasswordResult.parameters
                                    result.success(hashMapOf(
                                            "destination" to userCodeDeliveryDetails?.destination,
                                            "deliveryMedium" to userCodeDeliveryDetails?.deliveryMedium,
                                            "attributeName" to userCodeDeliveryDetails?.attributeName,
                                            "state" to forgotPasswordResult.state.name
                                    ))
                                }
                            }

                            override fun onError(e: Exception) {
                                Handler(Looper.getMainLooper()).post {
                                    result.error("Error", "Error requesting password reset", e.localizedMessage)
                                }
                            }
                        }
                )

        fun trackDevice(result: MethodChannel.Result) =
                AWSMobileClient.getInstance().deviceOperations.updateStatus(true, object : Callback<Void> {
                    override fun onResult(deviceUpdated: Void?) {
                        Handler(Looper.getMainLooper()).post {
                            result.success(true)
                        }
                    }

                    override fun onError(e: Exception) {
                        Handler(Looper.getMainLooper()).post {
                            result.error("Error", "Error updating device status", e.localizedMessage)
                        }
                    }

                })

        fun untrackDevice(result: MethodChannel.Result) =
                AWSMobileClient.getInstance().deviceOperations.updateStatus(false, object : Callback<Void> {
                    override fun onResult(deviceUpdated: Void?) {
                        Handler(Looper.getMainLooper()).post {
                            result.success(true)
                        }
                    }

                    override fun onError(e: Exception) {
                        Handler(Looper.getMainLooper()).post {
                            result.error("Error", "Error updating device status", e.localizedMessage)
                        }
                    }

                })

        fun forgetDevice(result: MethodChannel.Result) =
                AWSMobileClient.getInstance().deviceOperations.forget(object : Callback<Void> {
                    override fun onResult(deviceUpdated: Void?) {
                        Handler(Looper.getMainLooper()).post {
                            result.success(true)
                        }
                    }

                    override fun onError(e: Exception) {
                        Handler(Looper.getMainLooper()).post {
                            result.error("Error", "Error forgetting device", e.localizedMessage)
                        }
                    }

                })

        fun getDeviceDetails(result: MethodChannel.Result) =
                AWSMobileClient.getInstance().deviceOperations.get(object : Callback<Device> {
                    override fun onResult(device: Device) {
                        Handler(Looper.getMainLooper()).post {
                            result.success(hashMapOf(
                                    "createDate" to device.createDate.toString(),
                                    "deviceKey" to device.deviceKey,
                                    "lastAuthenticatedDate" to device.lastAuthenticatedDate,
                                    "lastModifiedDate" to device.lastModifiedDate,
                                    "attributes" to device.attributes
                            ))
                        }
                    }

                    override fun onError(e: Exception) {
                        Handler(Looper.getMainLooper()).post {
                            result.error("Error", "Error getting device details", e.localizedMessage)
                        }
                    }

                })

        //TODO: Handle list of devices
        fun listDevices(result: MethodChannel.Result) =
                AWSMobileClient.getInstance().deviceOperations.list(object : Callback<ListDevicesResult> {
                    override fun onResult(devices: ListDevicesResult) {
                        throw NotImplementedError()
                    }

                    override fun onError(e: Exception) {
                        Handler(Looper.getMainLooper()).post {
                            result.error("Error", "Error getting device list", e.localizedMessage)
                        }
                    }

                })

        fun federatedSignIn(result: MethodChannel.Result, identityProvider: String, token: String, customRoleARN: String?, cognitoIdentityId: String?) {
            var options: FederatedSignInOptions? = null
            customRoleARN?.let {
                options = FederatedSignInOptions.builder().customRoleARN(customRoleARN).build()
            }
            cognitoIdentityId?.let {
                options = FederatedSignInOptions.builder().cognitoIdentityId(cognitoIdentityId).build()
            }
            options?.let {
                AWSMobileClient.getInstance().federatedSignIn(identityProvider, token, options, object : Callback<UserStateDetails> {
                    override fun onResult(userStateDetails: UserStateDetails) {
                        Handler(Looper.getMainLooper()).post {
                            result.success(hashMapOf(
                                    "userState" to userStateDetails.userState.name,
                                    "userDetails" to userStateDetails.details
                            ))
                        }
                    }

                    override fun onError(e: Exception) {
                        Handler(Looper.getMainLooper()).post {
                            result.error("Error", "Error signing in", e.localizedMessage)
                        }
                    }

                })
            }

            AWSMobileClient.getInstance().federatedSignIn(identityProvider, token, object : Callback<UserStateDetails> {
                override fun onResult(userStateDetails: UserStateDetails) {
                    Handler(Looper.getMainLooper()).post {
                        result.success(hashMapOf(
                                "userState" to userStateDetails.userState.name,
                                "userDetails" to userStateDetails.details
                        ))
                    }
                }

                override fun onError(e: Exception) {
                    Handler(Looper.getMainLooper()).post {
                        result.error("Error", "Error signing in", e.localizedMessage)
                    }
                }

            })

        }
    }
}