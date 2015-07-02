//
//  FavouritelistTableViewController.h
//  Calendar
//
//  Created by emma on 15/6/4.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVSegmentController.h"
#import "LeftSwipeDeleteTableView.h"
#import "ActivityCell.h"
#import "Activity.h"

//typedef void(^BackBlock)(void);

@protocol FavouritelistTableViewControllerDelegate <NSObject>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface FavouritelistTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AVSegmentControllerDelegate>{
    UIView          *overLayView;               //一个遮罩视图
    UIView          *activityView;                  //放学年学期视图
}

@property (nonatomic, retain) LeftSwipeDeleteTableView *tableView;
@property (nonatomic, assign) id<FavouritelistTableViewControllerDelegate> delegate;

@property (nonatomic, retain) NSArray   *titles;
@property (nonatomic, retain) NSArray   *dates;
@property (nonatomic, retain) NSArray   *addresss;
@property (nonatomic, retain) NSArray   *sponsors;


//@property (nonatomic, copy) BackBlock   backBlock;

@property (nonatomic, retain) NSMutableArray   *activitiesArray;
@property (nonatomic, assign) NSInteger     clickIndex;


@end
