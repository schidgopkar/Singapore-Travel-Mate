//
//  SingaporeToursimBoardAPI.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 11/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "SingaporeToursimBoardAPI.h"
#import "Place.h"

@interface SingaporeToursimBoardAPI()

@property(nonatomic, strong) NSString *apiKey;
@property(nonatomic, strong) NSMutableArray *places;

@end

@implementation SingaporeToursimBoardAPI


-(instancetype)init{
    self = [super init];
    if (self) {
        _apiKey = @"mkFeYP700IB5kG2t9eNbqLpTLoaM3mZ4";
    }
    return self;
}


-(void)fetchPlacesNearLocation:(NSString*)location{
    
    _places = [[NSMutableArray alloc]init];
    
    location = @"1.369115,103.845436";
    
    NSString *urlString = [NSString stringWithFormat:@"https://tih-api.stb.gov.sg/map/v1/search/multidataset?location=%@&apikey=%@",location, _apiKey];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        NSArray *jsonDataArray = jsonDictionary[@"data"];
        
        for (NSDictionary* place in jsonDataArray) {
            NSString *uuid = place[@"uuid"];
            NSString *name = place[@"name"];
            NSString *category = place[@"categoryDescription"];
            NSNumber *rating = place[@"rating"];
            
            //Parsing Location
            NSDictionary *location = [place objectForKey:@"location"];
            NSNumber *latitude = [location objectForKey:@"latitude"];
            NSNumber *longitude = [location objectForKey:@"longitude"];
            
            //Parsing Address
            NSDictionary *address = [place objectForKey:@"address"];
            NSString *streetName = [address objectForKey:@"buildingName"];
            NSString *buildingName = [address objectForKey:@"buildingName"];
            NSString *postalCode = [address objectForKey:@"postalCode"];
            
            NSString *addressString = [NSString stringWithFormat:@"%@, %@, %@", buildingName, streetName, postalCode];
            
            //Parsing Thumbnail Image UUID
            
            NSArray *thumbnails = [place objectForKey:@"thumbnails"];
            NSDictionary *firstThumbnail = thumbnails.firstObject;
            NSString *thumbnailUuid = [firstThumbnail objectForKey:@"uuid"];
            
            //Dictionary for instatiating Place Object
            
            NSMutableDictionary *placeDictionary = [[NSMutableDictionary alloc]init];
            [placeDictionary setValue:uuid forKey:@"uuid"];
            [placeDictionary setValue:name forKey:@"name"];
            [placeDictionary setValue:category forKey:@"categoryDescription"];
            [placeDictionary setValue:rating forKey:@"rating"];
            [placeDictionary setValue:latitude forKey:@"latitude"];
            [placeDictionary setValue:longitude forKey:@"longitude"];
            [placeDictionary setValue:addressString forKey:@"address"];
            [placeDictionary setValue:thumbnailUuid forKey:@"thumbnailImage"];
            
            Place *place = [[Place alloc]init:placeDictionary];
            
            [self->_places addObject:place];
            
        }
        
        [self->_delegate fetchedPlaces:self->_places];
        
        NSLog(@"%@", jsonDictionary);
        NSLog(@"%@", error);
        
    }] resume];
    
    
}


@end
