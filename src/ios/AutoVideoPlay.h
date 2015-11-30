#import <Cordova/CDV.h>

@interface AutoVideoPlay : CDVPlugin
{
   NSString* fileURL;
}

- (void) autoplay:(CDVInvokedUrlCommand*)command;

@end