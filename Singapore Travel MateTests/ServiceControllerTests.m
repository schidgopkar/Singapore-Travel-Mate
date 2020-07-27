//
//  ServiceControllerTests.m
//  Singapore Travel MateTests
//
//  Created by Shrikant Chidgopkar on 27/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ServiceController.h"
#import "MockNSURLSession.h"

@interface ServiceControllerTests : XCTestCase

@property(nonatomic,strong) ServiceController *serviceController;
@property(nonatomic, strong)NSString *validURLString;

@end

@implementation ServiceControllerTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    _serviceController = [[ServiceController alloc]init];
    
    _validURLString = @"https://tih-api.stb.gov.sg/map/v1/search/multidataset?location=1.282203,103.863539&apikey=mkFeYP700IB5kG2t9eNbqLpTLoaM3mZ4&radius=5000&distinct=Yes";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


-(void)testFetchFromURL_invalidSession_fails_withErrorCode100{
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expected completion handler to be called with error code 100"];
    
    _serviceController.session = nil;
    
    [_serviceController fetchFromUrl:_validURLString withCompletion:^(NSData *data, NSError *error) {
        
        if (error.code == 110) {
            [expectation fulfill];
        }else{
            [expectation setInverted:YES];
        }
    }];
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
    
}

-(void)testFetchFromURL_invalidURL_fails_withErrorCode101{
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expected completion handler to be called with error code 101"];
    
    [_serviceController fetchFromUrl:nil withCompletion:^(NSData *data, NSError *error) {
       
        if (error.code == 101) {
            [expectation fulfill];
        }else{
            [expectation setInverted:YES];
        }
        
        [self waitForExpectationsWithTimeout:1 handler:nil];
        
    }];
    
}

-(void)testfetchFromURL_validURL_callsDataTask_onURLSession_withTheSameURL{
    
    NSURL *expectedURL = [NSURL URLWithString:_validURLString];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Expected dataTask to be called on URLSession with same url"];
    
    MockNSURLSession *mockUrlSession = [[MockNSURLSession alloc]init];
    
    mockUrlSession.dataTaskExpectation = expectation;
    mockUrlSession.expectedURL = expectedURL;
    
    _serviceController.session = mockUrlSession;
    
    [_serviceController fetchFromUrl:_validURLString withCompletion:^(NSData *data, NSError *error) {
        
    }];
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
    
}

@end
