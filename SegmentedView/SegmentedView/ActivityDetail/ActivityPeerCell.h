//
//  ActivityPeerCell.h
//  Calendar
//
//  Created by emma on 15/6/8.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailCell.h"

// 添加消息机制
@protocol ActivityPeerCellDelegate <NSObject>


@end


@interface ActivityPeerCell : ActivityDetailCell

@property (assign, nonatomic) id<ActivityPeerCellDelegate> delegate;

@end

