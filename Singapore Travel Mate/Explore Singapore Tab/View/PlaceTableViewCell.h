//
//  PlaceTableViewCell.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 14/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceTableViewCellViewModel.h"
#import "PlaceTableViewCellProtocol.h"

@interface PlaceTableViewCell : UITableViewCell <PlaceTableViewCellProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet UILabel *placeRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeCategoryLabel;
@property(strong, nonatomic) PlaceTableViewCellViewModel *viewModel;


-(void)setUp;

@end

