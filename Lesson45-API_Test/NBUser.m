//
//  NBUser.m
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 2/27/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBUser.h"

@interface NBUser ()

@end

@implementation NBUser


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
