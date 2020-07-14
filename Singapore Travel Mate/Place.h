//
//  Place.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 11/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place : NSObject

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *uuid;
@property(strong, nonatomic) NSString *category;
@property(strong, nonatomic) NSNumber *rating;
@property(strong, nonatomic) NSString *thumbnailImageUuid;
@property(strong, nonatomic) NSNumber *latitude;
@property(strong, nonatomic) NSNumber *longitude;
@property(strong, nonatomic) NSString *address;

-(instancetype)init:(NSDictionary*)placeDictionary;

@end

