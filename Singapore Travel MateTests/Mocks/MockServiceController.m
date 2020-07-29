//
//  MockServiceController.m
//  Singapore Travel MateTests
//
//  Created by Shrikant Chidgopkar on 28/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "MockServiceController.h"

@implementation MockServiceController


- (void)fetchFromUrl:(NSString *)urlString withCompletion:(void (^)(NSData *, NSError *))comletionHandler{
    
    comletionHandler(_dataToReturnOnSuccess, nil);
    
}

@end
