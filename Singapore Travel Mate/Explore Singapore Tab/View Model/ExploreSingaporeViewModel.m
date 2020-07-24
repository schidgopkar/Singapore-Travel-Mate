//
//  ExploreSingaporeViewModel.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 24/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "ExploreSingaporeViewModel.h"


@implementation ExploreSingaporeViewModel


-(instancetype)initWithView:(id <ExploreSingaporeViewControllerProtocol>)view{
    
    self = [super init];
    if (self) {
        self.view = view;
    }
    return self;
}


- (void)performInitialSetup{
    
    [_view setUpGoogleMapView];
    [_view setUpTableContainerView];
    [_view setUpGestureRecognizers];
    
}


@end
