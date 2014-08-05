//
//  BCDViewController.h
//  SampleWidevineApp_
//
//  Created by Darius Oleskevicius on 05/08/2014.
//  Copyright (c) 2014 BC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BCOVPlayerSDK.h>

@interface BCDViewController : UIViewController<BCOVPlaybackControllerDelegate>
@property (nonatomic, strong) id<BCOVPlaybackController> playbackController;
@property (nonatomic, weak) id<BCOVPlaybackSession> currentPlaybackSession;
@property (nonatomic, strong) BCOVCatalogService *catalogService;

@end