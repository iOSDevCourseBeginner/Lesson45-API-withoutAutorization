//
//  NBWall.m
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 2/27/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBUserInfo.h"

@implementation NBUserInfo

- (instancetype) initWithServerResponce:(NSDictionary*) responceObject {
    self = [super init];
    if (self) {
        self.firstName = [responceObject objectForKey:@"first_name"];
        self.lastName = [responceObject objectForKey:@"last_name"];
        NSLog(@"----- %@ %@", self.firstName, self.lastName);
        
        self.ownerID = [responceObject objectForKey:@"id"];
        NSString* imageURL = [responceObject objectForKey:@"photo_200"];
        NSString* imageURL50 = [responceObject objectForKey:@"photo_50"];
        if (imageURL) {
            self.imageURL = [NSURL URLWithString:imageURL];
            
        } else if (imageURL50) {
            self.imageURL50 = [NSURL URLWithString:imageURL50];
            NSLog(@"imageURL50 - %@", imageURL50);
            
        }
    }
    return self;
}

@end
