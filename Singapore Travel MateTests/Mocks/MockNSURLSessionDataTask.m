//
//  MockNSURLSessionDataTask.m
//  Singapore Travel MateTests
//
//  Created by Shrikant Chidgopkar on 27/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "MockNSURLSessionDataTask.h"


@implementation MockNSURLSessionDataTask



- (void)resume{
    [_resumeExpectation fulfill];
    
    if(_compleTionHandler){
        _compleTionHandler(_dataToReturn, _responseToReturn, _errorToReturn);
    }
    
}

@end
