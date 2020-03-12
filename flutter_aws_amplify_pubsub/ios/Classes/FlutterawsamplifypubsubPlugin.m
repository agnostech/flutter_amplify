#import "FlutterawsamplifypubsubPlugin.h"
#if __has_include(<flutterawsamplifypubsub/flutterawsamplifypubsub-Swift.h>)
#import <flutterawsamplifypubsub/flutterawsamplifypubsub-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutterawsamplifypubsub-Swift.h"
#endif

@implementation FlutterawsamplifypubsubPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterawsamplifypubsubPlugin registerWithRegistrar:registrar];
}
@end
