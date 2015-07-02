//
//  ActivityInfoCell.m
//  Calendar
//
//  Created by emma on 15/6/3.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "ActivityInfoCell.h"

@implementation ActivityInfoCell
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
    
    [self generateInfoCell];
    
    return self;
}

-(void)generateInfoCell{
    
    CGFloat padding = 20;
    
    UILabel *activitytitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding/2, 50, 20)];
    activitytitleLabel.text = @"名    称";
    activitytitleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:activitytitleLabel];
    
    UILabel *activityLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, padding/2, 150, 20)];
    NSString *title = _activity.title;
    activityLabel.text = title;
    activityLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:activityLabel];
    
    UILabel *timetitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(activityLabel.frame) + 6, 50, 20)];
    timetitleLabel.text = @"日    期";
    timetitleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:timetitleLabel];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(activityLabel.frame) + 6, 150, 20)];
    NSString *date = _activity.date;
    dateLabel.text = date;
    dateLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:dateLabel];
    
    
    UILabel *addresstitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(dateLabel.frame) + 6, 50, 20)];
    addresstitleLabel.text = @"地    点";
    addresstitleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:addresstitleLabel];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(dateLabel.frame) + 6, 150, 20)];
    NSString *address = _activity.address;
    addressLabel.text = address;
    addressLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:addressLabel];
    
    UILabel *sponsortitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, CGRectGetMaxY(addressLabel.frame) + 6, 50, 20)];
    sponsortitleLabel.text = @"发起者";
    sponsortitleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:sponsortitleLabel];
    
    UILabel *sponsorLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, CGRectGetMaxY(addressLabel.frame) + 6, 150, 20)];
    NSString *sponsor = _activity.sponsor;
    sponsorLabel.text = sponsor;
    sponsorLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:sponsorLabel];
    
    
    self.height = CGRectGetMaxY(sponsorLabel.frame) + padding/2;
    
    
}


@end
