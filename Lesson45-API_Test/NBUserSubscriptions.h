//
//  NBUserSubscriptions.h
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 3/5/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBUserSubscriptions : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* screenName;
@property (strong, nonatomic) NSURL* imageURL;
@property (strong, nonatomic) NSString* ownerID;

- (instancetype) initWithServerResponce:(NSDictionary*) responceObject;

@end
