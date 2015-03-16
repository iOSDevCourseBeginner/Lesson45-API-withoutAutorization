//
//  NBUserFollowers.m
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 3/6/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBUserFollowers.h"

@implementation NBUserFollowers

- (instancetype) initWithServerResponce:(NSDictionary*) responceObject {
    self = [super init];
    if (self) {
        self.firstName = [responceObject objectForKey:@"first_name"];
        self.lastName = [responceObject objectForKey:@"last_name"];
        self.ownerID = [responceObject objectForKey:@"user_id"];
        NSString* imageURL = [responceObject objectForKey:@"photo_100"];
        if (imageURL) {
            self.imageURL = [NSURL URLWithString:imageURL];
            
        }
        
    }
    return self;
}

@end
