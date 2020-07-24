//
//  ServiceController.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 23/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "ServiceController.h"
#import "NSObject+NSURLSession_Protocol.h"

@interface ServiceController()

@property(strong, nonatomic) NSURLSessionDataTask *dataTask;

@end


@implementation ServiceController

-(instancetype)init{
    self = [super init];
    if (self) {
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

-(void)fetchFromUrl:(NSString*)urlString withCompletion:(void (^)(NSData* data, NSError *error))comletionHandler{
    
    if (!_session) {
        comletionHandler(NULL, [NSError errorWithDomain:@"ServiceController" code:100 userInfo:Nil]);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if(!url){
        comletionHandler(NULL, [NSError errorWithDomain:@"ServiceController" code:101 userInfo:Nil]);
    }
    
    _dataTask = [_session dataTaskWithURL:url completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  error) {
        
        if (error) {
            comletionHandler(NULL, error);
            return;
        }
        
        if (response) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
            if ([httpResponse statusCode] == 200) {
                comletionHandler(data,NULL);
                return;
            }
        }
        
        comletionHandler(NULL, [NSError errorWithDomain:@"ServiceController" code:101 userInfo:Nil]);
        return;
    }];
    
    [_dataTask resume];
    
    
}

@end
