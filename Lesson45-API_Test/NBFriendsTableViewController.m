//
//  ViewController.m
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 2/25/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBFriendsTableViewController.h"
#import "NBServerManager.h"
#import "NBUser.h"
#import "UIImageView+AFNetworking.h"
#import "NBUserInfoTableViewController.h"

@interface NBFriendsTableViewController ()

@property (strong, nonatomic) NSMutableArray* friednsArray;
@property (assign, nonatomic) BOOL loadingData;
@end

@implementation NBFriendsTableViewController

static NSInteger friendInRequest = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.friednsArray = [NSMutableArray new];
    self.loadingData = YES;
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.getFriendsList.queue", NULL);
    dispatch_async(serialQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getFriendsFromServer];
       
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - API

- (void) getFriendsFromServer {
    [[NBServerManager sharedManager] getFriendsWithOffset:[self.friednsArray count]
     andCount:friendInRequest
     onSuccess:^(NSArray *friends) {
         [self.friednsArray addObjectsFromArray:friends];
         NSMutableArray* newPath = [NSMutableArray array];
         for (int i = (int)[self.friednsArray count] - (int)[friends count]; i < [self.friednsArray count ]; i++) {
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


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
        if (!self.loadingData) {
            self.loadingData = YES;
            
            dispatch_queue_t serialQueue = dispatch_queue_create("com.getFriendsList.queue", NULL);
            dispatch_async(serialQueue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self getFriendsFromServer];
                    
                });
            });
            
        }
    }
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friednsArray count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString* indentifier = @"Cell";
    UITableViewCell* cell        = [tableView dequeueReusableCellWithIdentifier:indentifier];

    if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];

    }

    NBUser* friend      = [self.friednsArray objectAtIndex:indexPath.row];
    UIFont *font = [UIFont fontWithName:@"HelvetivaNeue" size:13.f];
    cell.textLabel.font = font;
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];
    
        NSURLRequest* request = [NSURLRequest requestWithURL:friend.imageURL];
        __weak UITableViewCell* weakCell = cell;
        cell.imageView.image = nil;
        
        [cell.imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            weakCell.imageView.image = image;
            [weakCell layoutSubviews];
            
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
    
    return cell;
    
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NBUser* user = [self.friednsArray objectAtIndex:indexPath.row];
    NBUserInfoTableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"NBWallTableViewController"];
    vc.ownerID = user.ownerID;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
    
}


@end
