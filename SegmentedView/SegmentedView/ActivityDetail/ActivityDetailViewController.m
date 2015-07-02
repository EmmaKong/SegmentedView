//
//  ActivityDetailViewController.m
//  Calendar
//
//  Created by emma on 15/5/14.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityInfoCell.h"
#import "ActivityPeerCell.h"
#import "ActivityTimeCell.h"
#import "ActivityPeerViewController.h"
#import "ActivityDetailEditViewController.h"

@interface ActivityDetailViewController ()

@end

@implementation ActivityDetailViewController


- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];  // grouped tableview
    if(!self){
        return nil;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"事项详情";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGFloat padding = 20;
    
    ActivityInfoCell *infoCell = [[ActivityInfoCell alloc] init: self.activity];
    // 编辑 按钮
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    editBtn.frame = CGRectMake(infoCell.frame.size.width - padding - 50, (infoCell.frame.size.height - 20)/2, 50 , 20);
    editBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    editBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(clickeditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [infoCell.contentView addSubview:editBtn];
    ActivityDetailSection *detailSection = [ActivityDetailSection sectionWithHeaderTitle:nil cells:@[infoCell]];
    
    ActivityTimeCell *timeCell = [[ActivityTimeCell alloc] init: self.activity];
    //设定 按钮
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    setBtn.frame = CGRectMake(timeCell.frame.size.width - padding - 50, (timeCell.frame.size.height - 20)/2, 50 , 20);
    setBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    setBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [setBtn setTitle:@"设定" forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(clicksetBtn:) forControlEvents:UIControlEventTouchUpInside];
    [timeCell.contentView addSubview:setBtn];
    // 时间label
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,(timeCell.frame.size.height - 20)/2, 150, 20)];
//    NSString *begintime = self.activity.begintime;
//    NSString *endtime = self.activity.endtime;
//    self.timeLabel.text = [NSString stringWithFormat:@"%@~%@",begintime, endtime];

    self.timeLabel.text = @"08:00~08:05";  // 默认时间
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    [timeCell.contentView addSubview:self.timeLabel];


    ActivityDetailSection *timeSection = [ActivityDetailSection sectionWithHeaderTitle:nil cells:@[timeCell]];
    
    
    ActivityPeerCell *peerCell = [[ActivityPeerCell alloc] init];
    //同伴查看按钮
    UIButton *peerBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    peerBtn.frame = CGRectMake(peerCell.frame.size.width - padding - 50, padding, 50 , 20);
    
    peerBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    peerBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [peerBtn setTitle:@"查看" forState:UIControlStateNormal];
    [peerBtn addTarget:self action:@selector(clickPeerBtn:) forControlEvents:UIControlEventTouchUpInside];
    [peerCell.contentView addSubview:peerBtn];
    
    ActivityDetailSection *peerSection = [ActivityDetailSection sectionWithHeaderTitle:nil cells:@[peerCell]];
    
    
    self.sections = @[detailSection, timeSection, peerSection];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


-(void)clickeditBtn:(id)sender{
    NSLog(@"编辑事项");
    ActivityDetailEditVIewController *activityedit = [[ActivityDetailEditVIewController alloc] init];
    activityedit.activity = self.activity;
    [self.navigationController pushViewController:activityedit animated:YES];
    
}

-(void)clickPeerBtn:(id)sender{
    
    NSLog(@"查看同伴");
    ActivityPeerViewController* activitypeer = [[ActivityPeerViewController alloc]init];
    [self.navigationController pushViewController:activitypeer animated:YES];

    
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    ActivityTimePickerView *pickerView = (ActivityTimePickerView *)actionSheet;
    self.activity.begintime = pickerView.activity.begintime;
    self.activity.endtime = pickerView.activity.endtime;
    
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select%@~%@",self.activity.begintime, self.activity.endtime);
        self.timeLabel.text = [NSString stringWithFormat:@"%@~%@",self.activity.begintime, self.activity.endtime];
        
        
    }
}

-(void)clicksetBtn:(id)sender{
    NSLog(@"时间设定");
    ActivityTimePickerView *pickerView = [[ActivityTimePickerView alloc] initWithTitle:@"时间设定" delegate:self];
    if (self.timeLabel.text) {
        pickerView.activity = self.activity;
    }
    [pickerView showInView:self.view];
    
}

@end
