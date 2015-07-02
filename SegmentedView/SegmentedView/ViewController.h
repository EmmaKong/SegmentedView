//
//  ViewController.h
//  SegmentedView
//
//  Created by emma on 15/7/2.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSwipeDeleteTableView.h"
#import "ActivitySegmentViewController.h"

@interface ViewController : UIViewController

@property (nonatomic, retain) ActivitySegmentViewController *segmentView;
@property (nonatomic, retain) NSMutableArray   *activitiesArray;


@end

