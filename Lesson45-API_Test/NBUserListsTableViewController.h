//
//  NBUserSubscriptionsTableViewController.h
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 3/5/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    getSubscribersFromServer,
    getFollowersFromServer,

} getDataFromServer;

@interface NBUserListsTableViewController : UITableViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) NSString* ownerID;
@property (assign, nonatomic) getDataFromServer typeRequest;

@end
