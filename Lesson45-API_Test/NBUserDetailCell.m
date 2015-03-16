//
//  NBUserDetailCellTableViewCell.m
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 3/11/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBUserDetailCell.h"

@implementation NBUserDetailCell

- (void)awakeFromNib {
    self.userMainPhoto.frame = CGRectMake(0, 0, 100, 100);
    self.userMainPhoto.layer.cornerRadius = CGRectGetWidth(self.userMainPhoto.frame);
    self.userMainPhoto.clipsToBounds = YES;
    self.userMainPhoto.layer.borderWidth = 3.f;
    self.userMainPhoto.layer.borderColor = [[UIColor whiteColor] CGColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
