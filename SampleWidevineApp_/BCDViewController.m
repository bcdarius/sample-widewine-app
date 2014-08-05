//
//  BCDViewController.m
//  WidevineSampleApp
//
//  Created by Darius Oleskevicius on 15/06/2014.
//  Copyright (c) 2014 com.brightcove. All rights reserved.
//

#import "BCOVWidevine.h"
#import "BCDViewController.h"


@interface BCDViewController ()



@end

@implementation BCDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 
    
    BCOVPlayerSDKManager *playbackManager = [BCOVPlayerSDKManager sharedManager];
    
    // Create the Widevine session provider.
    id<BCOVPlaybackSessionProvider> widevineSessionProvider = [playbackManager createWidevineSessionProviderWithOptions:[[BCOVWidevineSessionProviderOptions alloc] init]];
    
    id<BCOVPlaybackController> playbackController = [playbackManager createPlaybackControllerWithSessionProvider:widevineSessionProvider viewStrategy:[self viewStrategy]];
    
    self.catalogService = [[BCOVCatalogService alloc] initWithToken:@"**********YUTg.."]; // for security reasons token is excluded here
    
    playbackController.delegate = self;
    self.playbackController = playbackController;
    
    self.playbackController.view.frame = self.view.bounds;
    self.playbackController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:self.playbackController.view];
    
    NSString *videoFields = @"FLVFullLength,videoStillURL,name,shortDescription,referenceId,id,accountId,customFields,FLVURL,cuePoints,HLSURL,wvmRenditions";
    NSDictionary *options = @{@"video_fields" : videoFields,@"media_delivery" : @""};

    
    [self.catalogService findWidevinePlaylistWithPlaylistID:@"3555052315001" parameters:options completion:^(BCOVPlaylist *playlist, NSDictionary *jsonResponse, NSError *error) {
        
        if (playlist)
        {
            [self.playbackController setVideos:playlist.videos];
            self.playbackController.autoPlay = YES;
            self.playbackController.autoAdvance = YES;
        }
        else
        {
            NSLog(@"Error retrieving playlist: %@", error);
        }
        
    }];

}


- (id)viewStrategy
{
    return [[BCOVPlayerSDKManager sharedManager] defaultControlsViewStrategy];
}

- (BCOVVideo *)videoWithURL:(NSURL *)url
{
    BCOVSource *source = [[BCOVSource alloc] initWithURL:url deliveryMethod:kBCOVSourceDeliveryWVM properties:nil];
    return [[BCOVVideo alloc] initWithSource:source cuePoints:[BCOVCuePointCollection collectionWithArray:@[]] properties:@{}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
