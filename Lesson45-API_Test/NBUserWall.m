//
//  NBUserWall.m
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 3/10/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBUserWall.h"

@implementation NBUserWall


- (instancetype) initWithServerResponce:(NSDictionary*) responceObject {
    self = [super init];
    if (self) {
        NSString* textString = [responceObject objectForKey:@"text"];
        self.text = [textString stringByReplacingOccurrencesOfString:@"<br>" withString:@""];
        NSDateFormatter *dateWithFormat = [[NSDateFormatter alloc] init];
        [dateWithFormat setDateFormat:@"MM dd yyyy"];
        NSTimeInterval Date = [[responceObject objectForKey:@"date"] intValue];
        NSDate *dateValue = [NSDate dateWithTimeIntervalSince1970:Date];
        self.date = [dateWithFormat stringFromDate:dateValue];
        NSDictionary* attachments = [[responceObject objectForKey:@"attachment"] objectForKey:@"photo"];
        self.postImageURL = [NSURL URLWithString:[attachments objectForKey:@"src_big"]];
        NSLog(@"postImageURL -%@", self.postImageURL);
        self.heightImage = [[attachments objectForKey:@"height"] integerValue] / 2;
        
    }
    return self;
    
}


@end
