//
//  ViewController.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 11/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExploreSingaporeViewModel.h"
#import "PlaceTableViewCell.h"


@import GoogleMaps;

@interface ExploreSingaporeViewController : UIViewController

@property (weak, nonatomic) IBOutlet GMSMapView *googleMapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableContainerViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *tableContainerView;
@property(strong, nonatomic) ExploreSingaporeViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIButton *searchThisAreaButton;



@end


