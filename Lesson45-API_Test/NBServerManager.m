//
//  NBServerManager.m
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 2/25/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBServerManager.h"
#import "AFNetworking.h"
#import "NBUser.h"
#import "NBUserInfo.h"
#import "NBUserSubscriptions.h"
#import "NBUserFollowers.h"
#import "NBUserWall.h"

@interface NBServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOpertationManager;
@end

@implementation NBServerManager


+ (NBServerManager*) sharedManager {
    static NBServerManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NBServerManager alloc] init];
        
    });
    return manager;
    
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL* baseURL = [NSURL URLWithString:@"https://api.vk.com/method/"];
        self.requestOpertationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
        
    }
    return self;
    
}


- (void) getFriendsWithOffset:(NSInteger) offset andCount:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void (^)(NSError* error, NSInteger statusCode)) failure {
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"9262459",     @"user_id",
                            @"name",        @"order",
                            @(count),       @"count",
                            @(offset),      @"offset",
                            @"photo_100",    @"fields",
                            @"nom",         @"name_case",
                            nil];
    
    [self.requestOpertationManager GET:@"friends.get" parameters:params
                               success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {

       NSLog(@"JSON: %@", responseObject);
       NSArray* dictArray           = [responseObject objectForKey:@"response"];
       NSMutableArray* objectsArray = [NSMutableArray array];

    for (NSDictionary* dictionary in dictArray) {
       NBUser* user                 = [[NBUser alloc] initWithServerResponce:dictionary];
       [objectsArray addObject:user];

        }
        if (success) {
        success(objectsArray);
            
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error, operation.response.statusCode);
            
        }
    }];
}


- (void) getUserInfoWithOwnerID:(NSString*) ownerID
                      onSuccess:(void(^)(NSArray* userArray))success
                      onFailure:(void (^)(NSError* error, NSInteger statusCode))failure {
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            ownerID,            @"user_ids",
                            @"photo_200",       @"fields",
                            @"photo_50",        @"fields",
                            @"Nom",             @"name_case",
                            nil];
    
    [self.requestOpertationManager GET:@"users.get" parameters:params
       success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
           
    NSLog(@"JSON: %@", responseObject);
    NSArray* dictArray           = [responseObject objectForKey:@"response"];
    NSMutableArray* userArray = [NSMutableArray array];
       
    for (NSDictionary* dictionary in dictArray) {
        NBUserInfo* userWithInfo   = [[NBUserInfo alloc] initWithServerResponce:dictionary];
        [userArray addObject:userWithInfo];
           
    }
    if (success) {
        success(userArray);
           
    }
       
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       NSLog(@"Error: %@", error);
       if (failure) {
           failure(error, operation.response.statusCode);
           
       }
   }];
}



- (void) getSubscriptionsWithOwnerID:(NSString*)ownerID andCount:(NSInteger)count andOffset:(NSInteger)offset
                           onSuccess:(void(^)(NSArray* subscriptions))success
                           onFailure:(void (^)(NSError* error, NSInteger statusCode))failure {
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            ownerID,        @"user_id",
                            @"1",           @"extended",
                            @(count),       @"count",
                            @(offset),      @"offset",
                            @"photo_100",   @"fields",
                            @"nom",         @"name_case",
                            nil];
    
    [self.requestOpertationManager GET:@"users.getSubscriptions" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        NSArray* dictArray = [responseObject objectForKey:@"response"];
        NSMutableArray* objectsArray = [NSMutableArray array];
        
        for (NSDictionary* dictionary in dictArray) {
            NBUserSubscriptions* userSubscriptions = [[NBUserSubscriptions alloc] initWithServerResponce:dictionary];
            [objectsArray addObject:userSubscriptions];
            
        }
        if (success) {
            success(objectsArray);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error, operation.response.statusCode);
            
        }
    }];
}

- (void) getFollowersWithOwnerID:(NSString*)ownerID andCount:(NSInteger)count andOffset:(NSInteger)offset
                       onSuccess:(void(^)(NSArray* followers))success
                       onFailure:(void (^)(NSError* error, NSInteger statusCode))failure {
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            ownerID,        @"user_id",
                            @(count),       @"count",
                            @(offset),      @"offset",
                            @"photo_100",   @"fields",
                            @"nom",         @"name_case",
                            nil];
    
    [self.requestOpertationManager GET:@"users.getFollowers" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        NSArray* dictArray = [[responseObject objectForKey:@"response"] objectForKey:@"items"];
        NSMutableArray* objectsArray = [NSMutableArray array];
        
        for (NSDictionary* items in dictArray) {
            NBUserFollowers* userFollowers = [[NBUserFollowers alloc] initWithServerResponce:items];
            [objectsArray addObject:userFollowers];
            
        }
        if (success) {
            success(objectsArray);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error, operation.response.statusCode);
            
        }
    }];
}


- (void) getWallWithOwnerID:(NSString*)ownerID andCount:(NSInteger)count andOffset:(NSInteger)offset
                       onSuccess:(void(^)(NSArray* wallArray))success
                       onFailure:(void (^)(NSError* error, NSInteger statusCode))failure {
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            ownerID,        @"owner_id",
                            @(count),       @"count",
                            @(offset),      @"offset",
                            @"owner",       @"filter",
                            @"0",           @"extended",
                            nil];
    
    [self.requestOpertationManager GET:@"wall.get" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        NSArray* dictArray = [responseObject objectForKey:@"response"];
        if ([dictArray count] > 1) {
            dictArray = [dictArray subarrayWithRange:NSMakeRange(1, [dictArray count] - 1)];
            
        } else {
            dictArray = nil;
            
        }
        NSMutableArray* objectsArray = [NSMutableArray array];
        
        for (NSDictionary* object in dictArray) {
            NBUserWall* usersWall = [[NBUserWall alloc] initWithServerResponce:object];
            [objectsArray addObject:usersWall];
            
        }
        if (success) {
            success(objectsArray);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error, operation.response.statusCode);
            
        }
    }];
}


@end
