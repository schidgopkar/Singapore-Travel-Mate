//
//  SingaporeToursimBoardAPI.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 11/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "SingaporeToursimBoardAPI.h"

@interface SingaporeToursimBoardAPI()

@property(nonatomic, strong) NSString *apiKey;

@end

@implementation SingaporeToursimBoardAPI


-(instancetype)init{
    self = [super init];
    if (self) {
        _apiKey = @"mkFeYP700IB5kG2t9eNbqLpTLoaM3mZ4";
    }
    [self fetchPlacesNearLocation:@""];
    return self;
}


-(void)fetchPlacesNearLocation:(NSString*)location{
    
    location = @"1.369115,103.845436";
    
    NSString *urlString = [NSString stringWithFormat:@"https://tih-api.stb.gov.sg/map/v1/search/multidataset?location=%@&apikey=%@",location, _apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        NSArray *jsonDataArray = jsonDictionary[@"data"];
        
        for (NSDictionary* place in jsonDataArray) {
            NSString *name = place[@"name"];
            NSLog(@"%@", name);
        }
        
        NSLog(@"%@", jsonDictionary);
        NSLog(@"%@", error);
        
    }] resume];
    
    
}


@end
