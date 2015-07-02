//
//  ActivityDetailViewController.h
//  Calendar
//
//  Created by emma on 15/5/14.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailTableViewController.h"
#import "Activity.h"
#import "ActivityTimePickerView.h"

@interface ActivityDetailViewController : ActivityDetailTableViewController< UIActionSheetDelegate>



@property (nonatomic,retain) Activity *activity;

@property (nonatomic,retain) UILabel *timeLabel;


@end
