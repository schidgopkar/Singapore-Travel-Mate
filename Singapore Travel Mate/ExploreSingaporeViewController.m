//
//  ViewController.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 11/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "ExploreSingaporeViewController.h"
#import "SingaporeToursimBoardAPI.h"

@interface ExploreSingaporeViewController ()

@end

@implementation ExploreSingaporeViewController


-(void)setUpGoogleMapView{
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:1.3521 longitude:103.8198 zoom:10] ;
    
    [_googleMapView animateToCameraPosition:camera];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpGoogleMapView];
    
    SingaporeToursimBoardAPI *api = SingaporeToursimBoardAPI.new;
    
    
    [api fetchPlacesNearLocation:@""];
    
    
    
    
    
}


@end
