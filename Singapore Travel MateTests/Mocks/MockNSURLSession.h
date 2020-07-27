//
//  MockNSURLSession.h
//  Singapore Travel MateTests
//
//  Created by Shrikant Chidgopkar on 27/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSURLSessionProtocol.h"
#import <XCTest/XCTest.h>
#import "MockNSURLSessionDataTask.h"


@interface MockNSURLSession : NSObject <NSURLSessionProtocol>

@property(nonatomic, strong) XCTestExpectation * dataTaskExpectation;
@property(nonatomic, strong) NSURL *expectedURL;
@property(nonatomic, strong) MockNSURLSessionDataTask * dataTaskToReturn;


-(instancetype)init;

@end

