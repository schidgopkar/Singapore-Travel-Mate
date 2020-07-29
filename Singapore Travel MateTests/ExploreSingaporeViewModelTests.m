//
//  ExploreSingaporeViewModelTests.m
//  Singapore Travel MateTests
//
//  Created by Shrikant Chidgopkar on 28/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MockServiceController.h"
#import "PlaceModel.h"
#import "ExploreSingaporeViewModel.h"
#import "MockExploreSingaporeViewController.h"

@interface ExploreSingaporeViewModelTests : XCTestCase

@property(strong, nonatomic)NSData *stubDataToReturn;
@property(strong,nonatomic)MockExploreSingaporeViewController *mockExploreSingaporeViewController;
@property(strong, nonatomic)MockServiceController *mockServiceController;
@property(strong, nonatomic)PlaceModel *placeModelWithStubbedServiceController;


@end

@implementation ExploreSingaporeViewModelTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    NSString *path = [bundle pathForResource:@"validPlacesList" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    _stubDataToReturn = data;
    
    _mockServiceController = [[MockServiceController alloc]init];
    
    _mockServiceController.dataToReturnOnSuccess = _stubDataToReturn;
    
    _placeModelWithStubbedServiceController = [[PlaceModel alloc]init];
    _placeModelWithStubbedServiceController.serviceController = _mockServiceController;
    
    _mockExploreSingaporeViewController = [[MockExploreSingaporeViewController alloc]init];
    
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}



-(void)testsearchThisAreaButtonTapped_updates_placesArray_withDownloadedPlacesData_fromPlaceModel{
    
    ExploreSingaporeViewModel *viewModel = [[ExploreSingaporeViewModel alloc]initWithView:_mockExploreSingaporeViewController];
    
    viewModel.placeModel = _placeModelWithStubbedServiceController;
    viewModel.placeModel.placeDownloadDelegate = viewModel;
    
    viewModel.searchLocationString = @"";
    viewModel.radiusString = @"";
    
    [viewModel searchThisAreaButtonTapped];
    
    XCTAssertEqual(viewModel.places,_placeModelWithStubbedServiceController.places);
    
}

@end
