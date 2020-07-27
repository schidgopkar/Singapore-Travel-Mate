//
//  PlaceModel.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 24/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceController.h"


@protocol PlaceModelProtocol <NSObject>

-(void)didfetchedPlaces:(NSArray*)places;


@end


@interface PlaceModel : NSObject

@property(nonatomic, strong) ServiceController *serviceController;
@property(nonatomic, strong) NSMutableArray *places;
@property(nonatomic, weak) id <PlaceModelProtocol> placeDownloadDelegate;


-(void)fetchPlacesNearLocation:(NSString*)location withRadius:(NSString*)radius;

@end

