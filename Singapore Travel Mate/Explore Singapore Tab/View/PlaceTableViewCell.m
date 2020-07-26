//
//  PlaceTableViewCell.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 14/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "PlaceTableViewCell.h"
#import <SDWebImage/SDWebImage.h>


@implementation PlaceTableViewCell


CAGradientLayer *gradient;

-(void)setUp{
    [_viewModel setUp];
}


- (void)setPlaceName:(NSString *)placeName{
    _placeNameLabel.text = placeName ;
}

- (void)setPlaceCategoryName:(NSString *)placeCategoryName{
    _placeCategoryLabel.text = placeCategoryName;
}

- (void)setPlaceRating:(NSString *)placeRating{
    _placeRatingLabel.text = placeRating;
}

- (void)setPlaceImageWithImageUrl:(NSURL *)url{
    UIImage *placeholderImage = [UIImage imageNamed:@"singapore"];
    [_placeImageView sd_setImageWithURL:url placeholderImage:placeholderImage];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    gradient = [[CAGradientLayer alloc]init];
    gradient.frame = _placeImageView.bounds;
    UIColor *clearColor = [UIColor clearColor];
    UIColor *blackColor = [UIColor blackColor];
    gradient.colors = @[(id)clearColor.CGColor,(id)blackColor.CGColor];
    [_placeImageView.layer insertSublayer:gradient atIndex:0];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    gradient.frame = self.contentView.frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
