//
//  ViewController.m
//  SegmentedView
//
//  Created by emma on 15/7/2.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"SegmentedViewController";
    
    //self.view.backgroundColor = [UIColor clearColor];
    
    _segmentView = [[ActivitySegmentViewController alloc] init];
    
    // 将 segmentviewcontroller 添加至activityviewcontroller
    [self addChildViewController:_segmentView];
    [self.view addSubview:_segmentView.view];
    
    
}



@end
