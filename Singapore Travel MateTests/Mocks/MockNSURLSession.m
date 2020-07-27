//
//  MockNSURLSession.m
//  Singapore Travel MateTests
//
//  Created by Shrikant Chidgopkar on 27/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "MockNSURLSession.h"

@implementation MockNSURLSession


- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataTaskToReturn = [[MockNSURLSessionDataTask alloc]init];
    }
    return self;
}



- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completionHandler {
    if([_expectedURL.absoluteString compare:url.absoluteString] == NSOrderedSame){
        [_dataTaskExpectation fulfill];
    }
    
    _dataTaskToReturn.compleTionHandler = completionHandler;
    
    return _dataTaskToReturn;
}

@end
