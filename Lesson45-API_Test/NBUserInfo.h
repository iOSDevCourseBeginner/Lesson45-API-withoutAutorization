//
//  NBWall.h
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 2/27/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBUserInfo : NSObject


@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSURL* imageURL;
@property (strong, nonatomic) NSURL* imageURL50;
@property (strong, nonatomic) NSString* ownerID;

- (instancetype) initWithServerResponce:(NSDictionary*) responceObject;


@end
