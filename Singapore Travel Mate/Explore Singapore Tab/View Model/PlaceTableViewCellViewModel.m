//
//  PlaceTableViewCellViewModel.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 24/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "PlaceTableViewCellViewModel.h"

@implementation PlaceTableViewCellViewModel


- (instancetype)initWithModel:(Place*)model
{
    self = [super init];
    if (self) {
        self.place = model;
    }
    return self;
}

-(void)setView:(id <PlaceTableViewCellProtocol>)view{
    
    self.placeTableViewCell = view;
}

-(void)setUp{
    
    NSString *placeName = _place.name;
    NSURL *placeImageURL = [NSURL URLWithString:_place.thumbnailImageURL];
    NSString *placeCategoryName = _place.category;
    NSString *placeRating =[NSString stringWithFormat:@"%@ ⭐️", _place.rating];
        
    [_placeTableViewCell setPlaceName:placeName];
    [_placeTableViewCell setPlaceImageWithImageUrl:placeImageURL];
    [_placeTableViewCell setPlaceCategoryName:placeCategoryName];
    [_placeTableViewCell setPlaceRating:placeRating];
}



@end
