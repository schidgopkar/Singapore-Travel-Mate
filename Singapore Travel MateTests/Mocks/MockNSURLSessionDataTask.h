//
//  MockNSURLSessionDataTask.h
//  Singapore Travel MateTests
//
//  Created by Shrikant Chidgopkar on 27/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>


@interface MockNSURLSessionDataTask : NSURLSessionDataTask

@property(nonatomic, strong)XCTestExpectation *resumeExpectation;
@property(nonatomic, strong) NSData *dataToReturn;
@property(nonatomic, strong) NSURLResponse *responseToReturn;
@property(nonatomic, strong) NSError *errorToReturn;

@property(nonatomic, copy) void (^compleTionHandler) (NSData *data, NSURLResponse *response, NSError *error);

@end

