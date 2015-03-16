//
//  NBUserWallCell.m
//  Lesson45-API_Test
//
//  Created by Nick Bibikov on 3/11/15.
//  Copyright (c) 2015 Nick Bibikov. All rights reserved.
//

#import "NBUserWallCell.h"

@implementation NBUserWallCell

- (void)awakeFromNib {
    
    self.wallHeaderImage.layer.cornerRadius = 20;
    self.wallHeaderImage.clipsToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (CGFloat) heightForText:(NSString*)text {
    CGFloat offset = 5.0;
    
    UIFont *font = [UIFont fontWithName:@"HelvetivaNeue" size:14.f];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0, -1);
    shadow.shadowBlurRadius = 0.5;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    [paragraph setLineBreakMode:NSLineBreakByWordWrapping];
    [paragraph setAlignment:NSTextAlignmentCenter];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                font, NSFontAttributeName,
                                paragraph, NSParagraphStyleAttributeName,
                                shadow, NSShadowAttributeName, nil];
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(320 - 2 * offset, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
 
    return CGRectGetHeight(rect) + 35 * offset;
    
}

@end
