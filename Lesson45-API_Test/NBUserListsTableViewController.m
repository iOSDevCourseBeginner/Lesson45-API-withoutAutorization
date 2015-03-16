//
//  NBUserSubscriptionsTableViewController.m
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 3/5/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBUserListsTableViewController.h"
#import "NBServerManager.h"
#import "NBUserSubscriptions.h"
#import "NBUserFollowers.h"
#import "UIImageView+AFNetworking.h"

@interface NBUserListsTableViewController ()

@property (strong, nonatomic) NSMutableArray* subscriptionsArray;
@property (strong, nonatomic) NSMutableArray* followersArray;
@property (assign, nonatomic) BOOL loadingData;
@end

@implementation NBUserListsTableViewController

static NSInteger countInRequest = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.typeRequest == getSubscribersFromServer) {
        self.subscriptionsArray = [NSMutableArray array];
        self.navigationItem.title = @"Following";
    
    } else {
        self.followersArray = [NSMutableArray array];
        self.navigationItem.title = @"Followers";
    }
    
    self.loadingData = YES;
    dispatch_queue_t serialQueue = dispatch_queue_create("com.getDataSubscAndFoll.queue", NULL);
    dispatch_async(serialQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getDataFromServer];
            
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - API

- (void) getDataFromServer {
    if (self.typeRequest == getSubscribersFromServer) {
    [[NBServerManager sharedManager] getSubscriptionsWithOwnerID:self.ownerID andCount:countInRequest
                                                       andOffset:[self.subscriptionsArray count]
                                                       onSuccess:^(NSArray *subscriptions) {
        [self.subscriptionsArray addObjectsFromArray:subscriptions];
        NSMutableArray* newPath = [NSMutableArray array];
        for (int i = (int)[self.subscriptionsArray count] - (int)[subscriptions count]; i < [self.subscriptionsArray count ]; i++) {
            [newPath addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            
        }
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:newPath withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        self.loadingData = NO;
        
    }
        onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"Error - %@, Status Code - %ld", [error localizedDescription], (long)statusCode);
                                                    
        }];
        
        
        
    } else if (self.typeRequest == getFollowersFromServer) {
        [[NBServerManager sharedManager] getFollowersWithOwnerID:self.ownerID andCount:countInRequest andOffset:[self.followersArray count] onSuccess:^(NSArray *followers) {
            [self.followersArray addObjectsFromArray:followers];
            NSMutableArray* newPath = [NSMutableArray array];
            for (int i = (int)[self.followersArray count] - (int)[followers count]; i < [self.followersArray count ]; i++) {
                [newPath addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                
            }
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:newPath withRowAnimation:UITableViewRowAnimationTop];
            [self.tableView endUpdates];
            self.loadingData = NO;
            
        }
            onFailure:^(NSError *error, NSInteger statusCode) {
            NSLog(@"Error - %@, Status Code - %ld", [error localizedDescription], (long)statusCode);
                                                               
        }];
        
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
        if (!self.loadingData) {
            self.loadingData = YES;
            
             [self getDataFromServer];
        }
    }
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.typeRequest == getSubscribersFromServer) {
        NSLog(@"subscriptionsArray count - %lu", (unsigned long)[self.subscriptionsArray count]);
        return [self.subscriptionsArray count];
        
    } else {
        NSLog(@"followersArray count - %lu", (unsigned long)[self.followersArray count]);
        return [self.followersArray count];
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* indentifier = @"Cell";
    UITableViewCell* cell        = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
    }
    
    if (self.typeRequest == getSubscribersFromServer) {
        NBUserSubscriptions* user = [self.subscriptionsArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", user.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", user.screenName];
        NSURLRequest* request = [NSURLRequest requestWithURL:user.imageURL];
        __weak UITableViewCell* weakCell = cell;
        cell.imageView.image = nil;
        
        [cell.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            weakCell.imageView.image = image;
            [weakCell layoutSubviews];
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"%@", [error localizedDescription]);
            
        }];
    
        
    } else if (self.typeRequest == getFollowersFromServer) {
        NBUserFollowers* user = [self.followersArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        NSURLRequest* request = [NSURLRequest requestWithURL:user.imageURL];
        __weak UITableViewCell* weakCell = cell;
        cell.imageView.image = nil;
        
        [cell.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            weakCell.imageView.image = image;
            [weakCell layoutSubviews];
            
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"%@", [error localizedDescription]);
            
        }];
        
    }
    return cell;
    
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
    
}

@end