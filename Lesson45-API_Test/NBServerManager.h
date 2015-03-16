//
//  NBServerManager.h
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 2/25/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBServerManager : NSObject

+ (NBServerManager*) sharedManager;

- (void) getFriendsWithOffset:(NSInteger) offset andCount:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void (^)(NSError* error, NSInteger statusCode)) failure;

- (void) getUserInfoWithOwnerID:(NSString*) ownerID
                      onSuccess:(void(^)(NSArray* userArray)) success
                      onFailure:(void (^)(NSError* error, NSInteger statusCode)) failure;


- (void) getSubscriptionsWithOwnerID:(NSString*)ownerID andCount:(NSInteger)count andOffset:(NSInteger)offset
                           onSuccess:(void(^)(NSArray* subscriptions))success
                           onFailure:(void (^)(NSError* error, NSInteger statusCode))failure;

- (void) getFollowersWithOwnerID:(NSString*)ownerID andCount:(NSInteger)count andOffset:(NSInteger)offset
                       onSuccess:(void(^)(NSArray* followers))success
                       onFailure:(void (^)(NSError* error, NSInteger statusCode))failure;


- (void) getWallWithOwnerID:(NSString*)ownerID andCount:(NSInteger)count andOffset:(NSInteger)offset
                  onSuccess:(void(^)(NSArray* wallArray))success
                  onFailure:(void (^)(NSError* error, NSInteger statusCode))failure;


@end
