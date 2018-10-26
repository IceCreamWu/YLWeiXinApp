//
//  YLSettingViewController.m
//  YLWeiXinAppDylib
//
//  Created by wuyonglin on 2018/10/25.
//  Copyright © 2018年 IceCreamWu. All rights reserved.
//

#import "YLSettingViewController.h"
#import "YLWeiXinApp.h"
#import "YLGlobalDefine.h" 
#import "YLConfigCenter.h"
#import <objc/runtime.h>

@interface YLSettingViewController ()

@property (nonatomic, strong) MMTableViewInfo *tableViewInfo;

@end

@implementation YLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitle];
    [self reloadTableData];
    
    MMTableView *tableView = [self.tableViewInfo getTableView];
    tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.navigationController.navigationBar.frame), 0, 0, 0);
    [self.view addSubview:tableView];
}

- (void)initTitle {
    self.title = kYLSettingTitle;
}

- (void)reloadTableData {
    MMTableViewSectionInfo *section1 = [objc_getClass("MMTableViewSectionInfo") sectionInfoDefaut];
    [section1 addCell:[self createHookLikeCell]];
//    [section1 addCell:[self createHookDiceCell]];
//    [section1 addCell:[self createHookMorraCell]];
    
    MMTableViewSectionInfo *section2 = [objc_getClass("MMTableViewSectionInfo") sectionInfoDefaut];
    [section2 addCell:[self createHookStepCell]];
    
    [self.tableViewInfo clearAllSection];
    [self.tableViewInfo addSection:section1];
    [self.tableViewInfo addSection:section2];
    
    MMTableView *tableView = [self.tableViewInfo getTableView];
    [tableView reloadData];
}

#pragma mark - Cell

- (MMTableViewCellInfo *)createHookLikeCell {
    BOOL hookLike = [YLConfigCenter sharedInstance].hookLike;
    MMTableViewCellInfo *cell = [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(switchHookLike:) target:self title:kYLSettingHookLikeTitle on:hookLike];
    return cell;
}

- (MMTableViewCellInfo *)createHookDiceCell {
    BOOL hookDice = [YLConfigCenter sharedInstance].hookDice;
    MMTableViewCellInfo *cell = [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(switchHookDice:) target:self title:kYLSettingHookDiceTitle on:hookDice];
    return cell;
}

- (MMTableViewCellInfo *)createHookMorraCell {
    BOOL hookMorra = [YLConfigCenter sharedInstance].hookMorra;
    MMTableViewCellInfo *cell = [objc_getClass("MMTableViewCellInfo") switchCellForSel:@selector(switchHookMorra:) target:self title:kYLSettingHookMorraTitle on:hookMorra];
    return cell;
}

- (MMTableViewCellInfo *)createHookStepCell {
    NSInteger stepCount = [YLConfigCenter sharedInstance].stepCount;
    NSString *text = [NSString stringWithFormat:@"%@", @(stepCount)];
    MMTableViewCellInfo *cell = [objc_getClass("MMTableViewCellInfo") editorCellForSel:@selector(editorHookStep:) target:self title:kYLSettingHookStepTitle margin:0 tip:kYLSettingHookStepTitle focus:NO text:text];
    return cell;
}

#pragma mark - Cell Event

- (void)switchHookLike:(UISwitch *)sender {
    [YLConfigCenter sharedInstance].hookLike = sender.on;
    [self reloadTableData];
}

- (void)switchHookDice:(UISwitch *)sender {
    [YLConfigCenter sharedInstance].hookDice = sender.on;
    [self reloadTableData];
}

- (void)switchHookMorra:(UISwitch *)sender {
    [YLConfigCenter sharedInstance].hookMorra = sender.on;
    [self reloadTableData];
}

- (void)editorHookStep:(UITextField *)sender {
    [self reloadTableData];
}

#pragma mark - Getter

- (MMTableViewInfo *)tableViewInfo {
    if (!_tableViewInfo) {
        _tableViewInfo = [[objc_getClass("MMTableViewInfo") alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    }
    return _tableViewInfo;
}

@end
