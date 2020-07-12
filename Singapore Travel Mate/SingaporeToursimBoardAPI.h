//
//  SingaporeToursimBoardAPI.h
//  Singapore Travel Mate
//
//  Created by Shrikant Chidgopkar on 11/07/20.
//  Copyright © 2020 Shrikant Chidgopkar. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SingaporeToursimBoardAPI : NSObject


-(void)fetchPlacesNearLocation:(NSString*)location;

@end

