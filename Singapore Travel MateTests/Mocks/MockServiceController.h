//
//  MockServiceController.h
//  Singapore Travel MateTests
//
//  Created by Shrikant Chidgopkar on 28/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "ServiceController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MockServiceController : ServiceController

@property(nonatomic, strong) NSData *dataToReturnOnSuccess;

@end

NS_ASSUME_NONNULL_END
