#import "AutoVideoPlay.h"
#import "CustomMoviePlayerViewController.h"

@implementation AutoVideoPlay

- (void)autoplay:(CDVInvokedUrlCommand*)command
{

    NSString* callbackId = [command callbackId];
    NSString* jsonString = [[command arguments] objectAtIndex:0];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* jsonResult = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSString* msg = [NSString stringWithFormat: @"Sended data is ,  %@", jsonString];
    
    
    CustomMoviePlayerViewController *moviePlayer = [[CustomMoviePlayerViewController alloc] initWithPath:[jsonResult objectForKey:@"url"]];
    [moviePlayer readyPlayer];
    
    [super.viewController presentViewController:moviePlayer animated:YES completion:nil];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self success:result callbackId:callbackId];
}

@end