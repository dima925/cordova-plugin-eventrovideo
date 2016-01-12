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
    
    fileURL = [jsonResult objectForKey:@"url"];
    NSURLRequest    *req  = [NSURLRequest requestWithURL:[NSURL URLWithString:fileURL]];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:req delegate:self];
    [conn start];
    
    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];
    
    [self success:result callbackId:callbackId];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    BOOL modalPresent = (BOOL)(self.viewController.presentedViewController);
    
    if(!modalPresent)
    {
        moviePlayer = [[CustomMoviePlayerViewController alloc] initWithPath:fileURL];
        [moviePlayer setVideoType:[response MIMEType]];
        [moviePlayer readyPlayer];
        [super.viewController presentViewController:moviePlayer animated:YES completion:nil];
        NSTimer *timerOut = [NSTimer scheduledTimerWithTimeInterval: 15.0
                                                             target: self
                                                           selector:@selector(onTick:)
                                                           userInfo: nil repeats:NO];
    }
}


-(void)onTick:(NSTimer *)timer {
    
    if(moviePlayer.isMediaPlaying==YES)
    {
        //nothing
    }
    else
    {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Timeout"
                                                        message:@"15 Second Timeout! Your 3G/4G connection is too slow to play this file"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


@end

