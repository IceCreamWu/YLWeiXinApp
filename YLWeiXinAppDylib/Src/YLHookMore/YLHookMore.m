//
//  YLHookMore.m
//  YLWeiXinAppDylib
//
//  Created by wuyonglin on 2018/10/25.
//  Copyright © 2018年 IceCreamWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CaptainHook/CaptainHook.h>
#import "YLWeiXinApp.h"
#import "YLGlobalDefine.h" 
#import "YLSettingViewController.h"

// 我的Tab
CHDeclareClass(MoreViewController)

CHOptimizedMethod0(self, void, MoreViewController, addSettingSection) {
    NSLog(@"YLHook MoreViewController addSettingSection");
    CHSuper0(MoreViewController, addSettingSection);
    
    MMTableViewCellInfo *settingCell = [objc_getClass("MMTableViewCellInfo") normalCellForSel:@selector(yl_gotoSettingVC) target:self title:kYLSettingTitle accessoryType:1];
    
    MMTableViewSectionInfo *sectionInfo = [objc_getClass("MMTableViewSectionInfo") sectionInfoDefaut];
    [sectionInfo addCell:settingCell];
    
    MMTableViewInfo *tableInfo = [self valueForKeyPath:@"m_tableViewInfo"];
    [tableInfo addSection:sectionInfo];
}

CHDeclareMethod0(void, MoreViewController, yl_gotoSettingVC) {
    NSLog(@"YLHook MoreViewController yl_gotoSettingVC");
    UIViewController *settingVC = [[YLSettingViewController alloc] init];
    settingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController PushViewController:settingVC animated:YES];
}

CHConstructor{
    NSLog(@"YLHook MoreViewController");
    CHLoadLateClass(MoreViewController);
    CHHook0(MoreViewController, addSettingSection);
}
