//
//  PlaceModel.m
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 24/7/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import "PlaceModel.h"
#import "Place.h"

@interface PlaceModel ()

@property(nonatomic, strong) NSString *apiKey;

@end


@implementation PlaceModel


-(instancetype)init{
    self = [super init];
    if (self) {
        _serviceController = [[ServiceController alloc]init];
        
        NSDictionary *keys;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"APIKeys" ofType:@"plist"];
        
        keys = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSString *singaporeTourismBoardAPIKey = [keys objectForKey:@"singaporeTourismBoardAPIKey"];
        
        _apiKey = singaporeTourismBoardAPIKey;
        
    }
    return self;
}

-(void)fetchPlacesNearLocation:(NSString*)location withRadius:(NSString*)radius{
    
    _places = [[NSMutableArray alloc]init];
    
    NSString *urlString = [NSString stringWithFormat:@"https://tih-api.stb.gov.sg/map/v1/search/multidataset?location=%@&apikey=%@&radius=%@&dataset=attractions&distinct=Yes",location, _apiKey, radius];
    
    NSLog(@"%@", urlString);
    
    
    [_serviceController fetchFromUrl:urlString withCompletion:^(NSData *data, NSError *error) {
        
        if(error){
            [self->_placeDownloadDelegate didfetchedPlaces:Nil];
            NSLog(@"%@", error);
            return;
        }
        
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
            
            NSString *imageURLString = [NSString stringWithFormat:@"https://tih-api.stb.gov.sg/media/v1/download/uuid/%@?apikey=%@&fileType=Default",thumbnailUuid, self->_apiKey];
            
            //Dictionary for instatiating Place Object
            
            NSMutableDictionary *placeDictionary = [[NSMutableDictionary alloc]init];
            [placeDictionary setValue:uuid forKey:@"uuid"];
            [placeDictionary setValue:name forKey:@"name"];
            [placeDictionary setValue:category forKey:@"categoryDescription"];
            [placeDictionary setValue:rating forKey:@"rating"];
            [placeDictionary setValue:latitude forKey:@"latitude"];
            [placeDictionary setValue:longitude forKey:@"longitude"];
            [placeDictionary setValue:addressString forKey:@"address"];
            [placeDictionary setValue:imageURLString forKey:@"thumbnailImage"];
            
            Place *place = [[Place alloc]init:placeDictionary];
            
            [self->_places addObject:place];
            
            NSLog(@"%@", imageURLString);
        }
        
        [self->_placeDownloadDelegate didfetchedPlaces:self->_places];
        
        NSLog(@"%@", jsonDictionary);
        NSLog(@"%@", error);
    }];
    
}


@end
