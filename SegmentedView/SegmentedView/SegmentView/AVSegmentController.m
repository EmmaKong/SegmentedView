//
//  AVSegmentController.m
//  Calendar
//
//  Created by emma on 15/6/4.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "AVSegmentController.h"
#import "AVSegmentView.h"

const void* _ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET = &_ARSEGMENTPAGE_CURRNTPAGE_SCROLLVIEWOFFSET;

@interface AVSegmentController ()

@property (nonatomic, strong) AVSegmentView *segmentView;
@property (nonatomic, strong) NSMutableArray *controllers;
@property (nonatomic, assign) CGFloat segmentToInset;
@property (nonatomic, weak) UIViewController<AVSegmentControllerDelegate> *currentDisplayController;
//@property (nonatomic, strong) NSLayoutConstraint *headerHeightConstraint;


@end

@implementation AVSegmentController

-(instancetype)initWithControllers:(UIViewController<AVSegmentControllerDelegate> *)controller, ...
{
    self = [super init];
    if (self) {
        NSAssert(controller != nil, @"the first controller must not be nil!");
        [self _setUp];
        UIViewController<AVSegmentControllerDelegate> *eachController;
        va_list argumentList;
        if (controller)
        {
            [self.controllers addObject: controller];
            va_start(argumentList, controller);
            while ((eachController = va_arg(argumentList, id)))
            {
                [self.controllers addObject:eachController];
            }
            va_end(argumentList);
        }
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _setUp];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self _setUp];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _baseConfigs];
    [self _baseLayout];
}

#pragma mark - public methods

-(void)setViewControllers:(NSArray *)viewControllers
{
    [self.controllers removeAllObjects];
    [self.controllers addObjectsFromArray:viewControllers];
}


#pragma mark - private methdos

-(void)_setUp
{
    //self.headerHeight = 200;
    self.segmentHeight = 44;
    self.segmentToInset = 200;
    self.segmentMiniTopInset = 0;
    self.controllers = [NSMutableArray array];
}

-(void)_baseConfigs
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([self.view respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.view.preservesSuperviewLayoutMargins = YES;
    }
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    self.segmentView = [[AVSegmentView alloc] init];
    [self.segmentView.segmentControl addTarget:self action:@selector(segmentControlDidChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentView];
    
    //all segment title and controllers
    [self.controllers enumerateObjectsUsingBlock:^(UIViewController<AVSegmentControllerDelegate> *controller, NSUInteger idx, BOOL *stop) {
        NSString *title = [controller segmentTitle];
        
        [self.segmentView.segmentControl insertSegmentWithTitle:title
                                                        atIndex:idx
                                                       animated:NO];
    }];
    
    // default at index 0
    self.segmentView.segmentControl.selectedSegmentIndex = 0;
    UIViewController<AVSegmentControllerDelegate> *controller = self.controllers[0];
    [controller willMoveToParentViewController:self];
    [self.view insertSubview:controller.view atIndex:0];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    
    [self _layoutControllerWithController:controller];
 //   [self addObserverForPageController:controller];
    
    self.currentDisplayController = self.controllers[0];
    
}

-(void)_baseLayout
{
    
    //segment
    // 左右
    self.segmentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    // 顶部， 偏移64
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:64]];
    // 高度
    [self.segmentView addConstraint:[NSLayoutConstraint constraintWithItem:self.segmentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.segmentHeight]];
}

-(void)_layoutControllerWithController:(UIViewController<AVSegmentControllerDelegate> *)pageController
{
    UIView *pageView = pageController.view;
    if ([pageView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        pageView.preservesSuperviewLayoutMargins = YES;
    }
    pageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
    UIScrollView *scrollView = [self scrollViewInPageController:pageController];
    if (scrollView) {
        scrollView.alwaysBounceVertical = YES;
        CGFloat topInset = self.segmentHeight;
        //fixed bootom tabbar inset
        CGFloat bottomInset = 0;
        if (self.tabBarController.tabBar.hidden == NO) {
            bottomInset = CGRectGetHeight(self.tabBarController.tabBar.bounds);
        }
        
        [scrollView setContentInset:UIEdgeInsetsMake(topInset, 0, bottomInset, 0)];
        //fixed first time don't show header view
        [scrollView setContentOffset:CGPointMake(0, -self.segmentHeight)];
    
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    }else{
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.segmentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:pageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:-self.segmentHeight]];
    }
    
}

-(UIScrollView *)scrollViewInPageController:(UIViewController <AVSegmentControllerDelegate> *)controller
{
    if ([controller respondsToSelector:@selector(streachScrollView)]) {
        return [controller streachScrollView];
    }else if ([controller.view isKindOfClass:[UIScrollView class]]){
        return (UIScrollView *)controller.view;
    }else{
        return nil;
    }
}

#pragma mark - event methods

-(void)segmentControlDidChangedValue:(UISegmentedControl *)sender
{
    //add new controller
    NSUInteger index = [sender selectedSegmentIndex];
    UIViewController<AVSegmentControllerDelegate> *controller = self.controllers[index];
    
    [self.currentDisplayController willMoveToParentViewController:nil];
    [self.currentDisplayController.view removeFromSuperview];
    [self.currentDisplayController removeFromParentViewController];
    [self.currentDisplayController didMoveToParentViewController:nil];
    
    [controller willMoveToParentViewController:self];
    [self.view insertSubview:controller.view atIndex:0];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    
    // reset current controller
    self.currentDisplayController = controller;
    //layout new controller
    [self _layoutControllerWithController:controller];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    
    //trigger to fixed header constraint
    UIScrollView *scrollView = [self scrollViewInPageController:controller];

    if (scrollView.contentOffset.y >= 1) {//zero
        [scrollView setContentOffset:scrollView.contentOffset];
    }else{
        [scrollView setContentOffset:CGPointMake(0, -self.segmentHeight)];
    }
    
}

#pragma mark - manage memory methods


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
