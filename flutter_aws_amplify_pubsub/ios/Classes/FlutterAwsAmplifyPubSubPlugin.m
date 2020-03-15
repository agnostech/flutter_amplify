#import "FlutterAwsAmplifyPubSubPlugin.h"
#if __has_include(<flutter_aws_amplify_pubsub/flutter_aws_amplify_pubsub-Swift.h>)
#import <flutter_aws_amplify_pubsub/flutter_aws_amplify_pubsub-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_aws_amplify_pubsub-Swift.h"
#endif

@implementation FlutterAwsAmplifyPubSubPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAwsAmplifyPubSubPlugin registerWithRegistrar:registrar];
}
@end
