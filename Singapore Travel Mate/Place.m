//
//  Place.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 11/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "Place.h"

@implementation Place

-(instancetype)init:(NSDictionary*)place{
    self = [super init];
    if (self) {
        _placeName = place[@"name"];
    }
    return self;
}

@end
