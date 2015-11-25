//
//  CustomMoviePlayerViewController.m
//
//  Copyright Liam Donaghy. 25/11/2015
//

#import "CustomMoviePlayerViewController.h"


@implementation CustomMoviePlayerViewController

@synthesize xmlCopyArray;

- (id)initWithPath:(NSString *)moviePath
{
    if (self = [super init])
    {
        movieURL = [NSURL URLWithString:moviePath];
    }
	return self;
}

- (void) moviePlayerLoadStateChanged:(NSNotification*)notification
{
	if ([mp loadState] != MPMovieLoadStateUnknown)
    {
       NSRange mp3Range = [[[movieURL absoluteString] lowercaseString] rangeOfString:[@"mp3" lowercaseString]];
        
        if(mp3Range.location != NSNotFound)
        {
            [mp view].frame = self.view.bounds;
            [[self view] addSubview:[mp view]];

            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = CGRectMake(0,50,100,55);
            button.tag = 1;
            button.backgroundColor = [UIColor blackColor];
            button.titleLabel.font = [UIFont systemFontOfSize:21.0];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitle:@"Done" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(audioPlayBackDidFinish:) forControlEvents:UIControlEventTouchUpInside];
            
            [ [mp view] addSubview:button];
        }
        else
        {
            [mp view].frame = self.view.bounds;
            [[self view] addSubview:[mp view]];
        }
        
        [mp play]; //autoplay
	}
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    [self closeNotifications];
    [mp stop];
    [self  dismissViewControllerAnimated:YES completion:nil];
}

-(void) audioPlayBackDidFinish :(id) sender
{
    [self closeNotifications];
    [mp stop];
    [self  dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [self cleanup];
}

- (void) cleanup
{
    mp=nil;
    movieURL=nil;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [self cleanup];
}

-(void) closeNotifications
{
    [[NSNotificationCenter 	defaultCenter]
     removeObserver:self
     name:MPMoviePlayerLoadStateDidChangeNotification
     object:nil];
    
    [[NSNotificationCenter 	defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:nil];
    
    [[NSNotificationCenter 	defaultCenter]
     removeObserver:self
     name:UIApplicationDidChangeStatusBarOrientationNotification
     object:nil];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [mp  stop];
}

- (void) readyPlayer
{
    mp =  [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    
    if ([mp respondsToSelector:@selector(loadState)])
    {
        [mp setControlStyle:MPMovieControlStyleFullscreen];
        [mp setFullscreen:YES];
        [mp prepareToPlay];
      
        
		[[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayerLoadStateChanged:)
                                                     name:MPMoviePlayerLoadStateDidChangeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(orientationDidChange:)
                                                     name: UIApplicationDidChangeStatusBarOrientationNotification
                                                   object: nil];
    }
}


- (void) orientationDidChange: (NSNotification *) note //reset control map
{
    [mp view].frame = self.view.bounds;
    [[self view] addSubview:[mp view]];
}


- (BOOL)shouldAutorotate {
    return YES;
}



@end
