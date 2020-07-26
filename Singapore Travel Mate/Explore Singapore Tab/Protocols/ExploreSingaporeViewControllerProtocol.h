//
//  ExploreSingaporeViewControllerProtocol.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 24/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>



@protocol ExploreSingaporeViewControllerProtocol <NSObject>

-(void)setUpGoogleMapView;
-(void)setUpTableContainerView;
-(void)setUpGestureRecognizers;
-(void)reloadTableView;
-(void)clearGoogleMap;
-(void)plotMarkerOnMap:(GMSMarker*)marker;
-(void)setTitle;

@end

