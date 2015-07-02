//
//  ActivityDetailEditVIewController.h
//  Calendar
//
//  Created by emma on 15/6/16.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

@interface ActivityDetailEditVIewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{

    UIScrollView *scroll;
    UIView* currentView;
    UITextField *titlefield;
    UITextField *datefield;
    UITextField *addressfield;
    UITextField *sponsorfield;
    UITextView *detailfield;

}

@property(nonatomic,retain) Activity* activity;

@end
