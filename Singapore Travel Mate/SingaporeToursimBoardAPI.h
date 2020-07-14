//
//  SingaporeToursimBoardAPI.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 11/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FetchedPlacesProtocol <NSObject>

-(void)fetchedPlaces:(NSArray*)places;

@end

@interface SingaporeToursimBoardAPI : NSObject

@property(nonatomic, weak) id <FetchedPlacesProtocol> delegate;


-(void)fetchPlacesNearLocation:(NSString*)location;

@end

