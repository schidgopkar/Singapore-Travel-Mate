//
//  Place.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 11/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "Place.h"

@implementation Place

-(instancetype)init:(NSDictionary*)placeDictionary{
    self = [super init];
    if (self) {
        _uuid = placeDictionary[@"uuid"];
        _name = placeDictionary[@"name"];
        _category = placeDictionary[@"categoryDescription"];
        _rating = placeDictionary[@"rating"];
        _latitude = placeDictionary[@"latitude"];
        _longitude = placeDictionary[@"longitude"];
        _address = placeDictionary[@"address"];
        _thumbnailImageUuid = placeDictionary[@"thumbnailImage"];
        
        
    }
    return self;
}

@end
