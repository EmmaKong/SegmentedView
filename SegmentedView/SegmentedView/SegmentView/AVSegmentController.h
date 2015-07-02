//
//  AVSegmentController.h
//  Calendar
//
//  Created by emma on 15/6/4.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import <UIKit/UIKit.h>

// segmentcontrollerdelegate
@protocol AVSegmentControllerDelegate <NSObject>

-(NSString *)segmentTitle;

@optional
-(UIScrollView *)streachScrollView;

@end


@interface AVSegmentController : UIViewController

@property (nonatomic, assign) CGFloat segmentHeight;
//@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat segmentMiniTopInset;
@property (nonatomic, assign, readonly) CGFloat segmentToInset;

@property (nonatomic, weak, readonly) UIViewController<AVSegmentControllerDelegate> *currentDisplayController;


@property (nonatomic, assign) BOOL freezenHeaderWhenReachMaxHeaderHeight;

-(instancetype)initWithControllers:(UIViewController<AVSegmentControllerDelegate> *)controller,... NS_REQUIRES_NIL_TERMINATION;

-(void)setViewControllers:(NSArray *)viewControllers;



@end
