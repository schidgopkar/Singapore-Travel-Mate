//
//  ServiceController.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 23/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSURLSessionProtocol.h"
#import "NSObject+NSURLSession_Protocol.h"


@interface ServiceController : NSObject

@property(strong, nonatomic) id <NSURLSessionProtocol> session;

-(void)fetchFromUrl:(NSString*)urlString withCompletion:(void (^)(NSData* data, NSError *error))comletionHandler;


@end

