//
//  ExploreSingaporeViewModel.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 24/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "ExploreSingaporeViewModel.h"


@implementation ExploreSingaporeViewModel


-(instancetype)initWithView:(id <ExploreSingaporeViewControllerProtocol>)view{
    
    self = [super init];
    if (self) {
        self.view = view;
        self.placeModel = [[PlaceModel alloc]init];
        self.placeModel.placeDownloadDelegate = self;
    }
    return self;
}

- (void)didfetchedPlaces:(NSArray *)places{
    
    _places = [[NSArray alloc]init];
    _places = places;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self->_places) {
            [self->_view displayNoPlacesFoundAlert];
        }else{
            [self plotPlacesMarkersOnMap];
            [self->_view reloadTableView];
        }
    });
    
}


- (void)performInitialSetup{
    
    [_view setUpNavBar];
    [_view setUpGoogleMapView];
    [_view setUpTableContainerView];
    [_view setUpGestureRecognizers];
    
}


-(void)googleMapViewLoadedWithLocation:(CLLocationCoordinate2D)coordinate{
    
    NSString *location = [NSString stringWithFormat:@"%f,%f",coordinate.latitude, coordinate.longitude];
    
    NSString *defaultRadiusString = @"5000";
    
    [_placeModel fetchPlacesNearLocation:location withRadius:defaultRadiusString];
}


- (void)googleMapViewIdleAtCameraPositon:(GMSCameraPosition*)position{
    
    NSString *location = [NSString stringWithFormat:@"%f,%f",position.target.latitude, position.target.longitude];
    
    _searchLocationString = location;
    
}

-(void)calculateRadiusOfVisibleRegionOnGoogleMap:(GMSMapView*)mapview{
    CGPoint centerPoint = mapview.center;

    CLLocationCoordinate2D centerCoordinate = [[mapview projection]coordinateForPoint:centerPoint];
    
    CGPoint topCenter = CGPointMake(mapview.frame.size.width / 2.0, 0);
    
    CGPoint topCenterPoint = [mapview convertPoint:topCenter fromView:mapview];
    
    CLLocationCoordinate2D topCenterCoodinate = [[mapview projection]coordinateForPoint:topCenterPoint];
    
    CLLocation *centerLocation = [[CLLocation alloc]initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
    CLLocation *topCenterLocation = [[CLLocation alloc]initWithLatitude:topCenterCoodinate.latitude longitude:topCenterCoodinate.longitude];
    
    CLLocationDistance radius = [centerLocation distanceFromLocation:topCenterLocation];
    
    _radiusString = [NSString stringWithFormat:@"%d", (int)(radius)]  ;
    
}


- (void)searchThisAreaButtonTapped{
    
    [_placeModel fetchPlacesNearLocation:_searchLocationString withRadius:_radiusString];
}

-(void)plotPlacesMarkersOnMap{
    
    [_view clearGoogleMap];
    
    for (Place *place in _places) {
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake([place.latitude doubleValue], [place.longitude doubleValue]);
        
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        
        [_view plotMarkerOnMap:marker];
        
    }
    
    
}

- (NSInteger)numberOfRowsInSection{
    
    return _places.count;
    
}


-(PlaceTableViewCellViewModel *)cellViewModel:(NSIndexPath*)indexPath{
    
    PlaceTableViewCellViewModel *cellViewModel = [[PlaceTableViewCellViewModel alloc]initWithModel:_places[indexPath.row]];
    
    return cellViewModel;
    
}



@end
