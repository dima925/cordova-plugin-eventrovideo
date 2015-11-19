#import "AutoVideoPlay.h"

@implementation AutoVideoPlay

- (void)autoplay:(CDVInvokedUrlCommand*)command
{

    NSString* callbackId = [command callbackId];
    NSString* jsonString = [[command arguments] objectAtIndex:0];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* jsonResult = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSLog(@"%@", jsonResult);
    NSString* msg = [NSString stringWithFormat: @"Sended data is ,  %@", jsonString];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self success:result callbackId:callbackId];
}

@end