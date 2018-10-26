//
//  YLWeiXinApp.h
//  YLWeiXinApp
//
//  Created by wuyonglin on 2018/10/25.
//  Copyright © 2018年 IceCreamWu. All rights reserved.
//

#ifndef YLWeiXinApp_h
#define YLWeiXinApp_h

#import <UIKit/UIKit.h>


#pragma mark - Hook Like

@interface WCUserComment

@property(nonatomic) unsigned int createTime;
@property(nonatomic) int type;
@property(nonatomic) int source;
@property(retain, nonatomic) NSString *content;
@property(retain, nonatomic) NSString *nickname;
@property(retain, nonatomic) NSString *username;
@property(retain, nonatomic) NSString *commentID;

@end



@interface WCDataItem

@property(retain, nonatomic) NSString *nickname;
@property(retain, nonatomic) NSString *username;
@property(retain, nonatomic) NSString *contentDesc;
@property(retain, nonatomic) NSMutableArray *likeUsers;
@property(retain, nonatomic) NSMutableArray *sharedGroupIDs;
@property(nonatomic) int likeCount;

+ (id)fromServerObject:(id)arg1;
- (BOOL)hasSharedGroup;

@end


@interface CContact

@property(retain, nonatomic) NSString *m_nsUsrName;
@property(retain, nonatomic) NSString *m_nsNickName;
@property(retain, nonatomic) NSString *m_nsRemark;

- (BOOL)isNormalFriendContact;

@end


@interface CContactMgr

- (id)getSelfContact;
- (id)getContactList:(unsigned int)arg1 contactType:(unsigned int)arg2;

@end



@interface MMServiceCenter

+ (id)defaultCenter;
- (id)getService:(Class)class;

@end

#pragma mark - Hook Step

@interface WCDeviceStepObject: NSObject

- (unsigned int)m7StepCount;

@end



#pragma mark - Hook More

@interface MoreViewController: UIViewController

- (void)addSettingSection;
- (void)yl_gotoSettingVC;

@end

@interface MMTableViewInfo

- (id)getSectionAt:(int)arg1;
- (id)getTableView;
- (void)clearAllSection;
- (void)addSection:(id)arg1;
- (void)insertSection:(id)arg1 At:(unsigned int)arg2;

@end

@interface MMTableViewSectionInfo

+ (id)sectionInfoDefaut;
+ (id)sectionInfoHeader:(id)arg1;
+ (id)sectionInfoHeader:(id)arg1 Footer:(id)arg2;
- (void)addCell:(id)arg1;

@end

@interface MMTableViewCellInfo

+ (id)normalCellForSel:(SEL)arg1 target:(id)arg2 title:(id)arg3 accessoryType:(long long)arg4;
+ (id)switchCellForSel:(SEL)arg1 target:(id)arg2 title:(id)arg3 on:(_Bool)arg4;
+ (id)normalCellForSel:(SEL)arg1 target:(id)arg2 title:(id)arg3 rightValue:(id)arg4 accessoryType:(long long)arg5;
+ (id)normalCellForTitle:(id)arg1 rightValue:(id)arg2;
+ (id)urlCellForTitle:(id)arg1 url:(id)arg2;
+ (id)editorCellForSel:(SEL)arg1 target:(id)arg2 tip:(id)arg3 focus:(_Bool)arg4 text:(id)arg5;
+ (id)editorCellForSel:(SEL)arg1 target:(id)arg2 title:(id)arg3 margin:(double)arg4 tip:(id)arg5 focus:(_Bool)arg6 text:(id)arg7;

@end

@interface MMTableView: UITableView

@end

#pragma mark - UICategory

@interface UINavigationController (LogicController)

- (void)PushViewController:(id)arg1 animated:(_Bool)arg2;

@end

#endif /* YLWeiXinApp_h */
