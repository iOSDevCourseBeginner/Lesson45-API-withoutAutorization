//
//  NBUserWall.h
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 3/10/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBUserWall : NSObject

@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSURL* imageURL_50;

@property (strong, nonatomic) NSString* date;
@property (strong, nonatomic) NSURL* postImageURL;
@property (assign, nonatomic) NSInteger heightImage;
@property (assign, nonatomic) NSInteger sizeText;

- (instancetype) initWithServerResponce:(NSDictionary*) responceObject;

@end
