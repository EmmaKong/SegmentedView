//
//  ActivityTimeCell.m
//  Calendar
//
//  Created by emma on 15/6/8.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "ActivityTimeCell.h"

@implementation ActivityTimeCell
{
    Activity *_activity;
}

- (instancetype)init:(Activity *)activity
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _activity = activity;
    
    [self generateTimeCell];
    
    return self;
}

-(void)generateTimeCell{
    
    CGFloat padding = 20;
    
    UILabel *activitytimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding/2, 50, 20)];
    activitytimeLabel.text = @"时间";
    activitytimeLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:activitytimeLabel];
    
//    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, padding/2, 150, 20)];
//    NSString *begintime = _activity.begintime;
//    NSString *endtime = _activity.endtime;
//    NSString *timetext = [NSString stringWithFormat:@"%@~%@",begintime, endtime];
//    timeLabel.text = timetext;
//    timeLabel.font = [UIFont systemFontOfSize:15];
//    [self.contentView addSubview:timeLabel];
    

}

@end
