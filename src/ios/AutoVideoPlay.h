#import <Cordova/CDV.h>

@class CustomMoviePlayerViewController;

@interface AutoVideoPlay : CDVPlugin
{
   NSString* fileURL;
   CustomMoviePlayerViewController *moviePlayer;
}

- (void) autoplay:(CDVInvokedUrlCommand*)command;

@end