//
//  ActivityTableViewCell.h
//  Calendar
//
//  Created by emma on 15/5/12.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityCellDelegate <NSObject>

- (void)choseActivity:(UIButton *)button;


@end

@interface ActivityCell : UITableViewCell


@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
@property (retain, nonatomic) IBOutlet UILabel *addressLabel;
@property (retain, nonatomic) IBOutlet UILabel *sponsorLabel;


@property (assign, nonatomic) id<ActivityCellDelegate> delegate;



@end
