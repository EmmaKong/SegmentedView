//
//  ActivityDetailTableViewController.m
//  Calendar
//
//  Created by emma on 15/6/3.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "ActivityDetailTableViewController.h"

@interface ActivityDetailTableViewController ()

@end

@implementation ActivityDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setting sections

- (void)setSections:(NSArray *)sections {
    _sections = sections;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ActivityDetailSection *activitySection = self.sections[section];
    return activitySection.headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    ActivityDetailSection *activitySection = self.sections[section];
    return activitySection.headerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    ActivityDetailSection *activitySection = self.sections[section];
    return activitySection.headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ActivityDetailSection *activitySection = self.sections[section];
    return activitySection.footerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    ActivityDetailSection *activitySection = self.sections[section];
    return activitySection.footerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    ActivityDetailSection *activitySection = self.sections[section];
    return activitySection.footerHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ActivityDetailSection *activitySection = self.sections[section];
    return activitySection.reuseEnabled ? activitySection.reusedCellCount : activitySection.cells.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityDetailSection *activitySection = self.sections[indexPath.section];
    
    if (activitySection.reuseEnabled) {
        return activitySection.reusedCellHeight;
    }
    
    else {
        ActivityDetailCell *cell = activitySection.cells[indexPath.row];
        return cell.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityDetailSection *activitySection = self.sections[indexPath.section];
    
    if (activitySection.reuseEnabled) {
        return activitySection.cellForRowBlock(tableView, indexPath.row);
    }
    
    else {
        return activitySection.cells[indexPath.row];
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ActivityDetailSection *activitySection = self.sections[indexPath.section];
    
    if (activitySection.reuseEnabled) {
        if (activitySection.reusedCellActionBlock) {
            activitySection.reusedCellActionBlock(indexPath.row);
        }
    }
    
    else {
        ActivityDetailCell *cell = activitySection.cells[indexPath.row];
        
        if (cell.actionBlock) {
            cell.actionBlock();
        }
    }
}

@end
