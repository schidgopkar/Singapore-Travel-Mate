//
//  ExploreSingaporeViewModel.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 24/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExploreSingaporeViewControllerProtocol.h"

@interface ExploreSingaporeViewModel : NSObject

@property(nonatomic, weak) id <ExploreSingaporeViewControllerProtocol> view;

-(instancetype)initWithView:(id <ExploreSingaporeViewControllerProtocol>)view;
-(void)performInitialSetup;

@end

