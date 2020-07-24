//
//  PlaceTableViewCell.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 14/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlaceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *placeImageView;
@property (weak, nonatomic) IBOutlet UILabel *placeRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeCategoryLabel;


@end

