//
//  ExploreSingaporeViewModel.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 24/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExploreSingaporeViewControllerProtocol.h"
#import "PlaceModel.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Place.h"
#import "PlaceTableViewCellViewModel.h"


@interface ExploreSingaporeViewModel : NSObject

@property(nonatomic, weak) id <ExploreSingaporeViewControllerProtocol> view;
@property(nonatomic, strong) PlaceModel *placeModel;
@property(nonatomic, strong) NSString *searchLocationString;
@property(nonatomic, strong) NSArray *places;

-(instancetype)initWithView:(id <ExploreSingaporeViewControllerProtocol>)view;
-(void)performInitialSetup;
-(void)searchThisAreaButtonTapped;
-(void)googleMapViewLoadedWithLocation:(CLLocationCoordinate2D)coordinate;
- (void)googleMapViewIdleAtCameraPositon:(GMSCameraPosition*)position;
-(void)plotPlacesMarkersOnMap;
-(PlaceTableViewCellViewModel *)cellViewModel:(NSIndexPath*)indexPath;
-(NSInteger)numberOfRowsInSection;
@end

