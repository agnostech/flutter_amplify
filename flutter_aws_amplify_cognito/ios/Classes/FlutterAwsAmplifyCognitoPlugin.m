#import "FlutterAwsAmplifyCognitoPlugin.h"
#if __has_include(<flutter_aws_amplify_cognito/flutter_aws_amplify_cognito-Swift.h>)
#import <flutter_aws_amplify_cognito/flutter_aws_amplify_cognito-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_aws_amplify_cognito-Swift.h"
#endif

@implementation FlutterAwsAmplifyCognitoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAwsAmplifyCognitoPlugin registerWithRegistrar:registrar];
}
@end
