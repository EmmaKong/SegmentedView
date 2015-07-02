//
//  FavouritelistTableViewController.m
//  Calendar
//
//  Created by emma on 15/6/4.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "FavouritelistTableViewController.h"
#import "ActivityDetailViewController.h"

#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
@interface FavouritelistTableViewController ()

@end

@implementation FavouritelistTableViewController

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
    
    //初始化表格
    _tableView = [[LeftSwipeDeleteTableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc] init];   // 添加一个tableview作为根视图
    
    [self.view addSubview:_tableView];
    
    //  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self performSelector:@selector(loadActivityDatas) withObject:nil afterDelay:0.5];
}

- (void)loadActivityDatas
{
    NSString *activityPath = [[NSBundle mainBundle] pathForResource:@"activities" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:activityPath];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    _activitiesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < array.count; i++) {
        Activity *activity = [[Activity alloc] initWithPropertiesDictionary:array[i]];
        activity.activitytag = [NSString stringWithFormat:@"%d",1200+i];  // 给每个activity添加 tag

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

// 删除 事项
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


// 选中某个事项cell，进入 事项详情页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ActivityDetailViewController *activitydetail = [[ActivityDetailViewController alloc] init];
    
    activitydetail.activity = _activitiesArray[indexPath.row];
    [self.navigationController pushViewController:activitydetail animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSString *)segmentTitle
{
    return @"关注活动";
}

-(UIScrollView *)streachScrollView
{
    return self.tableView;
}


@end
