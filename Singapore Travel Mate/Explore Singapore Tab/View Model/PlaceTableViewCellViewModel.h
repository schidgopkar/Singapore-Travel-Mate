//
//  PlaceTableViewCellViewModel.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 24/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Place.h"
#import "PlaceTableViewCellProtocol.h"


@interface PlaceTableViewCellViewModel : NSObject


@property(strong, nonatomic) Place * place;
@property(weak, nonatomic) id <PlaceTableViewCellProtocol> placeTableViewCell;


- (instancetype)initWithModel:(Place*)model;
-(void)setView:(id <PlaceTableViewCellProtocol>)view;
-(void)setUp;

@end

