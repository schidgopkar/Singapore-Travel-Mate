//
//  PlaceTableViewCellProtocol.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 24/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PlaceTableViewCellProtocol <NSObject>

-(void)setPlaceName:(NSString*)placeName;
-(void)setPlaceImageWithImageUrl:(NSURL*)url;
-(void)setPlaceCategoryName:(NSString*)placeCategoryName;
-(void)setPlaceRating:(NSString*)placeRating;

@end

