//
//  NBUserFollowers.h
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 3/6/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBUserFollowers : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* imageURL;
@property (strong, nonatomic) NSString* ownerID;

- (instancetype) initWithServerResponce:(NSDictionary*) responceObject;


@end
