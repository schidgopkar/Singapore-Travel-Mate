//
//  ServiceController.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 23/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "ServiceController.h"

@interface ServiceController()

@property(strong, nonatomic) NSURLSessionDataTask *dataTask;

@end


@implementation ServiceController

-(instancetype)init{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        self.session = session;
    }
    return self;
}

-(void)fetchFromUrl:(NSString*)urlString withCompletion:(void (^)(NSData* data, NSError *error))comletionHandler{
    
    if (_session == Nil) {
        comletionHandler(Nil, [NSError errorWithDomain:@"ServiceController" code:100 userInfo:Nil]);
        return;
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if(!url){
        comletionHandler(Nil, [NSError errorWithDomain:@"ServiceController" code:101 userInfo:Nil]);
    }
        
   _dataTask = [_session dataTaskWithURL:url completionHandler:^(NSData *  data, NSURLResponse *  response, NSError *  error) {
            
            if (error) {
                comletionHandler(Nil, error);
                return;
            }
            
            if (response) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*) response;
                if (data) {
                    if ([httpResponse statusCode] == 200) {
                        comletionHandler(data,Nil);
                        return;
                    }
                }
            }
            
            comletionHandler(Nil, [NSError errorWithDomain:@"ServiceController" code:101 userInfo:Nil]);
            return;
        }];
    
    [_dataTask resume];
    
}

@end
