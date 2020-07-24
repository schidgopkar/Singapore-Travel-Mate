//
//  PlaceTableViewCell.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 14/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "PlaceTableViewCell.h"

@implementation PlaceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // SHADOW AND BORDER FOR CELL
    //yourTableViewCell.contentView.layer.cornerRadius = 5
    self.contentView.layer.borderWidth = 0.5;
    self.contentView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.contentView.layer.masksToBounds = YES;
    self.layer.shadowColor = [[UIColor grayColor]CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowRadius = 2.0;
    self.layer.shadowOpacity = 1.0;
    self.layer.masksToBounds = NO;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius] CGPath];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
