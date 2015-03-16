//
//  NBUserSubscriptions.m
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 3/5/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBUserSubscriptions.h"

@implementation NBUserSubscriptions

- (instancetype) initWithServerResponce:(NSDictionary*) responceObject {
    self = [super init];
    if (self) {
        self.name = [responceObject objectForKey:@"name"];
        self.screenName = [responceObject objectForKey:@"screen_name"];
        self.ownerID = [responceObject objectForKey:@"gid"];
        NSString* imageURL = [responceObject objectForKey:@"photo_100"];
        if (imageURL) {
            self.imageURL = [NSURL URLWithString:imageURL];
            
        }
        
    }
    return self;
}

@end
