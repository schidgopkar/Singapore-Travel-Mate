//
//  ViewController.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 11/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "ExploreSingaporeViewController.h"
#import "SingaporeToursimBoardAPI.h"
#import "Place.h"
#import <QuartzCore/QuartzCore.h>
#import "PlaceTableViewCell.h"
#import <SDWebImage/SDWebImage.h>

@interface ExploreSingaporeViewController () <FetchedPlacesProtocol, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, GMSMapViewDelegate>

@property(strong, nonatomic)NSArray *places;
@property(strong, nonatomic)SingaporeToursimBoardAPI *api;

@end

@interface ExploreSingaporeViewController (ExploreSingaporeViewControllerProtocol)<ExploreSingaporeViewControllerProtocol>

@end

@implementation ExploreSingaporeViewController



- (IBAction)searchThisAreaButtonTapped:(UIButton *)sender {
    
    
    
}



-(void)fetchedPlaces:(NSArray *)places{
    _places = [[NSArray alloc]init];
    _places = places;
    
    dispatch_async(dispatch_get_main_queue(), ^{
           [self plotPlaceMarkersOnMap];
        [self->_tableView reloadData];
    });
}


-(Place*)placeAtIndex:(NSInteger)index{
    return [_places objectAtIndex:index];
}


- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    
    _api = [[SingaporeToursimBoardAPI alloc]init];
    
    _api.delegate = self;
    
    NSString *location = [NSString stringWithFormat:@"%f,%f",position.target.latitude, position.target.longitude];
    
    [_api fetchPlacesNearLocation:location];
    
}

-(void)plotPlaceMarkersOnMap{
    
    [_googleMapView clear];
    
    for (Place *place in _places) {
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake([place.latitude doubleValue], [place.longitude doubleValue]);
        
        GMSMarker *marker = [GMSMarker markerWithPosition:position];
        
        marker.map = _googleMapView;
        
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_viewModel == NULL) {
        _viewModel = [[ExploreSingaporeViewModel alloc]initWithView:self];
    }
    
    
    [_viewModel performInitialSetup];
    
    

    

    
    
}

-(void)upSwipe:(UISwipeGestureRecognizer*)gesture{
    
    [UIView animateWithDuration:0.3 animations:^{
        self->_tableContainerViewTopConstraint.constant = -self->_tableContainerView.frame.size.height;
        [self.view layoutIfNeeded];
    }];
    
}

-(void)downSwipe:(UISwipeGestureRecognizer*)gesture{
    
    [UIView animateWithDuration:0.3 animations:^{
        self->_tableContainerViewTopConstraint.constant = -60;
        [self.view layoutIfNeeded];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _places.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceTableViewCellIdentifier"];
    
    Place *place = [self placeAtIndex:indexPath.row];
    
    cell.placeNameLabel.text = place.name ;
    
    NSURL *placeImageURL = [NSURL URLWithString:place.thumbnailImageURL];
    
    [cell.placeImageView sd_setImageWithURL:placeImageURL];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self->_tableContainerViewTopConstraint.constant = -60;
            [self.view layoutIfNeeded];
        }];
    }
}



@end

@implementation ExploreSingaporeViewController (ExploreSingaporeViewControllerProtocol)


- (void)setUpGoogleMapView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:1.3521 longitude:103.8198 zoom:13] ;
    
    [_googleMapView animateToCameraPosition:camera];
    
    _googleMapView.delegate = self;
}

- (void)setUpTableContainerView{
    
    // border radius
    [_tableContainerView.layer setCornerRadius:10.0f];
    
    // border
    [_tableContainerView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_tableContainerView.layer setBorderWidth:1.5f];
    
    // drop shadow
    [_tableContainerView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_tableContainerView.layer setShadowOpacity:0.8];
    [_tableContainerView.layer setShadowRadius:5.0];
    [_tableContainerView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
}

- (void)setUpGestureRecognizers{
    
    UISwipeGestureRecognizer *swipeUpGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upSwipe:)];
    [swipeUpGesture setDirection:UISwipeGestureRecognizerDirectionUp];
    [_tableContainerView addGestureRecognizer:swipeUpGesture];
    
    UISwipeGestureRecognizer *swipeDownGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(downSwipe:)];
    [swipeDownGesture setDirection:UISwipeGestureRecognizerDirectionDown];
    [_tableContainerView addGestureRecognizer:swipeDownGesture];
    
}




@end

