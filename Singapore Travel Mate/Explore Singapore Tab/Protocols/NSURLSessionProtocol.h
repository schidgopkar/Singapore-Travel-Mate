//
//  NSURLSessionProtocol.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 23/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol NSURLSessionProtocol <NSObject>

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url
                        completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler;

@end


