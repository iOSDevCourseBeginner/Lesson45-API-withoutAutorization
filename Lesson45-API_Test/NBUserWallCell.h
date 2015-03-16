//
//  NBUserWallCell.h
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 3/11/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBUserWallCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *wallHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *wallHeaderTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *wallHeaderTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *wallPostImage;
@property (weak, nonatomic) IBOutlet UILabel *wallText;

+ (CGFloat) heightForText:(NSString*)text;

@end
