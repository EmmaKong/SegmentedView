//
//  ActivityTableViewCell.m
//  Calendar
//
//  Created by emma on 15/5/12.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (IBAction)checkAction:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(choseActivity:)]) {
        sender.tag = self.tag;
        [_delegate choseActivity:sender];
    }
}

@end
