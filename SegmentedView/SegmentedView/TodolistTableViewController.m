//
//  TodolistTableViewController.m
//  Calendar
//
//  Created by emma on 15/6/4.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "TodolistTableViewController.h"
#import "ActivityDetailViewController.h"

#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)

@interface TodolistTableViewController ()

@end

@implementation TodolistTableViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化表格
    _tableView = [[LeftSwipeDeleteTableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] init];   // 添加一个tableview作为根视图
    
    [self.view addSubview:_tableView];
    
    
    [self performSelector:@selector(loadActivityDatas) withObject:nil afterDelay:0.5];
    
    
}

- (void)loadActivityDatas
{

    NSString *activityPath = [[NSBundle mainBundle] pathForResource:@"todolist" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:activityPath];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    _activitiesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i++) {
        Activity *activity = [[Activity alloc] initWithPropertiesDictionary:array[i]];
        activity.activitytag = [NSString stringWithFormat:@"%d",i];
        [_activitiesArray addObject:activity];
        
    }
    [_tableView reloadData];
   // [self hideHUD];
}

// 每次显示的事项数目与 文件中项目数相同
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _activitiesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ActivityCell";
    
    ActivityCell *cell = (ActivityCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivityCell" owner:self options:nil] lastObject];
    }
    Activity *activity = _activitiesArray[indexPath.row];
    
    NSString *titletext = [NSString stringWithFormat:@"%@",activity.title];
    NSString *datetext = [NSString stringWithFormat:@"%@",activity.date];
    NSString *addresstext = [NSString stringWithFormat:@"%@",activity.address];
    NSString *sponsortext = [NSString stringWithFormat:@"%@",activity.sponsor];
    
    cell.tag = indexPath.row;
    cell.delegate = self;
    cell.titleLabel.text = titletext;
    cell.dateLabel.text = datetext;
    cell.addressLabel.text = addresstext;
    cell.sponsorLabel.text = sponsortext;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// 滑动删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_activitiesArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - UITableViewDelegate
// 每一行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ActivityDetailViewController *activitydetail = [[ActivityDetailViewController alloc]init];
    
    activitydetail.activity = _activitiesArray[indexPath.row];
    
    [self.navigationController pushViewController:activitydetail animated:YES];}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)segmentTitle
{
    return @"待办事项";
}

-(UIScrollView *)streachScrollView
{
    return self.tableView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}




@end
