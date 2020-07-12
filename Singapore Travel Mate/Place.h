//
//  Place.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 11/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property(strong, nonatomic) NSString *placeName;
@property(strong, nonatomic) NSString *placeID;
@property(strong, nonatomic) NSString *placeCategory;
@property(strong, nonatomic) NSString *placeThumbnailUuid;
@property(strong, nonatomic) NSString *latitude;
@property(strong, nonatomic) NSString *longitude;

-(instancetype)init:(NSDictionary*)place;

@end

