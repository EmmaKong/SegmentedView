//
//  ClassPeerTableViewController.h
//  Calendar
//
//  Created by emma on 15/5/27.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PeerCell.h"
#import "MBProgressHUD.h"

@interface ActivityPeerViewController : UIViewController<PeerCellDelegate, UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate, MBProgressHUDDelegate>
{
    MBProgressHUD   *_HUD;
    
}

@property (nonatomic, retain) NSMutableArray   *activitypeersArray;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end


