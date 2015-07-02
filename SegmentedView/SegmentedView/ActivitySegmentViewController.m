//
//  ActivitySegmentViewController.m
//  Calendar
//
//  Created by emma on 15/6/4.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "ActivitySegmentViewController.h"
#import "AVSegmentController.h"

//void *CusomHeaderInsetObserver = &CusomHeaderInsetObserver;

@interface ActivitySegmentViewController ()

@end

@implementation ActivitySegmentViewController


-(instancetype)init
{
     
    TodolistTableViewController *todotable = [[TodolistTableViewController alloc]  init];
    FavouritelistTableViewController *favouritetable = [[FavouritelistTableViewController alloc] init];
    
    
    self = [super initWithControllers:todotable,favouritetable, nil];
    if (self) {
        // your code
        self.segmentMiniTopInset = 64;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // [self addObserver:self forKeyPath:@"segmentToInset" options:NSKeyValueObservingOptionNew context:CusomHeaderInsetObserver];


}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    if (context == CusomHeaderInsetObserver) {
//        CGFloat inset = [change[NSKeyValueChangeNewKey] floatValue];
//        NSLog(@"inset is %f",inset);
//        
//    }
//}

//-(void)dealloc
//{
//    [self removeObserver:self forKeyPath:@"segmentToInset"];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
