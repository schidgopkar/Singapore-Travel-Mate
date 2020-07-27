//
//  ViewController.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 11/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "ExploreSingaporeViewController.h"
#import "Place.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/SDWebImage.h>

@interface ExploreSingaporeViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, GMSMapViewDelegate>
@property(nonatomic) CLLocationCoordinate2D initialCoordinate;

@end

@interface ExploreSingaporeViewController (ExploreSingaporeViewControllerProtocol)<ExploreSingaporeViewControllerProtocol>

@end

@implementation ExploreSingaporeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_viewModel) {
        _viewModel = [[ExploreSingaporeViewModel alloc]initWithView:self];
        [_viewModel performInitialSetup];
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    
}


- (IBAction)searchThisAreaButtonTapped:(UIButton *)sender {
    [_viewModel searchThisAreaButtonTapped];
}

- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position{
    [_viewModel googleMapViewIdleAtCameraPositon:position];
    [_viewModel calculateRadiusOfVisibleRegionOnGoogleMap:mapView];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [_viewModel googleMapViewLoadedWithLocation:_initialCoordinate];
    });
    
    if(_searchThisAreaButton.isHidden){
        [_searchThisAreaButton setHidden:NO];
    }
    
}

- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture{
    [_searchThisAreaButton setHidden:YES];
    [self animateTableContainerViewTopConstraintConstant:-60];
}

-(void)plotPlaceMarkersOnMap{
    [_viewModel plotPlacesMarkersOnMap];
}

-(void)animateTableContainerViewTopConstraintConstant:(CGFloat)constant{
    [UIView animateWithDuration:0.3 animations:^{
        self->_tableContainerViewTopConstraint.constant = constant;
        [self.view layoutIfNeeded];
    }];
}

-(void)upSwipe:(UISwipeGestureRecognizer*)gesture{
    [self animateTableContainerViewTopConstraintConstant: -self->_tableContainerView.frame.size.height];
    [_searchThisAreaButton setHidden:YES];
}

-(void)downSwipe:(UISwipeGestureRecognizer*)gesture{
    [self animateTableContainerViewTopConstraintConstant:-60];
    [_searchThisAreaButton setHidden:NO];

}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_viewModel numberOfRowsInSection];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlaceTableViewCellIdentifier"];
    
    PlaceTableViewCellViewModel *cellViewModel = [_viewModel cellViewModel:indexPath];
    
    cell.viewModel = cellViewModel;
    [cellViewModel setView:cell];
    
    [cell setUp];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y < 0) {
        [self animateTableContainerViewTopConstraintConstant:-60];
    }else if(scrollView.contentOffset.y > 0 && _tableContainerViewTopConstraint.constant == -250){
        [self animateTableContainerViewTopConstraintConstant: -self->_tableContainerView.frame.size.height];
    }
    
}


@end

@implementation ExploreSingaporeViewController (ExploreSingaporeViewControllerProtocol)


- (void)setUpGoogleMapView {
    
    _initialCoordinate = CLLocationCoordinate2DMake(1.282203,103.863539);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:_initialCoordinate.latitude longitude:_initialCoordinate.longitude zoom:13] ;
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSURL *styleUrl = [mainBundle URLForResource:@"style" withExtension:@"json"];
    NSError *error;
    
    // Set the map style by passing the URL for style.json.
    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
    
    if (!style) {
        NSLog(@"The style definition could not be loaded: %@", error);
    }
    
    _googleMapView.mapStyle = style;
    
    [_googleMapView animateToCameraPosition:camera];
    
    _googleMapView.delegate = self;
    
    _googleMapView.settings.myLocationButton = YES;
    
    [_googleMapView setMyLocationEnabled:YES];

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

- (void)clearGoogleMap{
    [_googleMapView clear];
}

- (void)plotMarkerOnMap:(GMSMarker *)marker{
    marker.icon = [UIImage imageNamed:@"redMarker"];
    marker.map = _googleMapView;
}

- (void)reloadTableView{
    [_tableView reloadData];
    [self animateTableContainerViewTopConstraintConstant:-250];
    [_searchThisAreaButton setHidden:YES];
}

- (void)setUpNavBar{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.navigationItem.title = @"Explore Singapore";
        
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        
        [self.navigationController.navigationBar setTranslucent:NO];
        
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:162.0f/255.0f green:162.0f/255.0f blue:157.0f/255.0f alpha:0.7f]];
        
        UINavigationBarAppearance *navigationBarAppearance = [self.navigationController.navigationBar standardAppearance];
        
        UIImage *backgroundImage = [UIImage imageNamed:@"singapore"];
        
        [navigationBarAppearance configureWithOpaqueBackground];
        
        [navigationBarAppearance setBackgroundImage:backgroundImage];
        [navigationBarAppearance setBackgroundColor:[UIColor whiteColor]];
        
        
        [navigationBarAppearance setLargeTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:34 weight:UIFontWeightSemibold]}];
        
        [self.navigationController.navigationBar setStandardAppearance:navigationBarAppearance];
        [self.navigationController.navigationBar  setScrollEdgeAppearance:navigationBarAppearance];
        
        
    });
    
    
    
    
}

- (void)displayNoPlacesFoundAlert{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Places Found" message:@"No places found for this area. Please try searching in another area." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alertController.view setTintColor:[UIColor systemRedColor]];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}




@end

