
//  NBWallTableViewController.m
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 2/27/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBUserInfoTableViewController.h"
#import "NBServerManager.h"
#import "NBUserInfo.h"
#import "NBUser.h"
#import "NBFriendsTableViewController.h"
#import "NBUserListsTableViewController.h"
#import "UIKit+AFNetworking.h"
#import "NBUserDetailCell.h"
#import "NBUserWall.h"
#import "NBUserWallCell.h"


@interface NBUserInfoTableViewController ()

@property (strong, nonatomic) NSArray* userArray;
@property (strong, nonatomic) NSMutableArray* wallArray;
@property (assign, nonatomic) NSInteger heightImage;
@property (assign, nonatomic) BOOL loadingData;
@property (strong, nonatomic) NBUserInfo* user;
@property (strong, nonatomic) NBUserDetailCell* detailCell;
@property (strong, nonatomic) NBUserWallCell* wallCell;
@end

@implementation NBUserInfoTableViewController

static NSInteger count = 10;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wallArray = [NSMutableArray array];
    self.navigationItem.title = @"User info";
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.myapp.queue", NULL);
    dispatch_async(serialQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getUserInfoWithOwnerID:self.ownerID];
            [self getUserWallWithOwnerID];
        });
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



#pragma mark - API

- (void) getUserInfoWithOwnerID:(NSString*) ownerID {
    [[NBServerManager sharedManager] getUserInfoWithOwnerID:ownerID
    onSuccess:^(NSArray *userArray) {
        self.userArray = [NSArray arrayWithArray:userArray];
        
        NBUserInfo* user = [self.userArray firstObject];
        self.user = user;
        NSString* fullName = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        self.navigationItem.title = fullName;
        self.detailCell.userNameLabel.text = [[NSString stringWithFormat:@"%@", fullName] uppercaseString];
        if (user.imageURL) {
            [self.detailCell.userMainPhoto setImageWithURL:user.imageURL];
        
        } else {
            self.detailCell.userMainPhoto.image = [UIImage imageNamed:@"deactivated_200"];
            
        }
        
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"%@", [error localizedDescription]);
        
  }];
    
}


- (void) getUserWallWithOwnerID {
    [[NBServerManager sharedManager] getWallWithOwnerID:self.ownerID andCount:count andOffset:[self.wallArray count] onSuccess:^(NSArray *wallArray) {
        [self.wallArray addObjectsFromArray:wallArray];
        NSLog(@"wallArray array count - - - -%lu", (unsigned long)[self.wallArray count]);
        self.loadingData = NO;
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error, NSInteger statusCode) {
        NSLog(@"%@", [error localizedDescription]);
        
    }];
    
}


#pragma mark - UITableViewDataSource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString* indentifier = @"headerCell";
        NBUserDetailCell* cell        = [tableView dequeueReusableCellWithIdentifier:indentifier];
        self.detailCell = cell;
        return cell;
            
    } else if (indexPath.section == 1) {
        static NSString* indentifier = @"wallCell";
        NBUserWallCell* cell         = [tableView dequeueReusableCellWithIdentifier:indentifier];
        
        NBUserWall* userWall = [self.wallArray objectAtIndex:indexPath.row];
        cell.wallHeaderTitleLabel.text = [NSString stringWithFormat:@"%@ %@", self.user.firstName, self.user.lastName];
        cell.wallHeaderTimeLabel.text = userWall.date;
        cell.wallText.text = userWall.text;
        [cell.wallHeaderImage setImageWithURL:self.user.imageURL];
        
        [cell.wallPostImage setImageWithURL:userWall.postImageURL];
        //self.heightImage = userWall.heightImage;
        self.wallCell = cell;
        return cell;
                
        }
    
    return nil;
    
}

#pragma mark - UITableViewDelegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
        
    } else {
        return [self.wallArray count];
        
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString: @"followersSegue"]) {
        NBUserListsTableViewController *destinationController = [segue destinationViewController];
        [destinationController setOwnerID:self.ownerID];
        [destinationController setTypeRequest:getSubscribersFromServer];
        
    } if ([[segue identifier] isEqualToString:@"followingSegue"]) {
        NBUserListsTableViewController *destinationController = [segue destinationViewController];
        [destinationController setOwnerID:self.ownerID];
        [destinationController setTypeRequest:getFollowersFromServer];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 260.f;
    
    } else {
        NBUserWall* userWall = [self.wallArray objectAtIndex:indexPath.row];
        if (!userWall.postImageURL && userWall.text) {
            userWall.sizeText = [NBUserWallCell heightForText:userWall.text];
            return userWall.sizeText + 20;
            
        }
        if (userWall.postImageURL && [userWall.text isEqualToString: @""]) {
            return userWall.heightImage /2 + 20;
            
            
        } else {
            userWall.sizeText = [NBUserWallCell heightForText:userWall.text];
            return  userWall.sizeText + userWall.heightImage/2 + 10;
            
        }
        return 0;
        
    }
    
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
        if (!self.loadingData) {
            self.loadingData = YES;
            
            [self getUserWallWithOwnerID];
        }
    }
}

@end
