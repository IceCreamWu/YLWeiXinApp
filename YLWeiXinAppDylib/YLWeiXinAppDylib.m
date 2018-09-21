//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  YLWeiXinAppDylib.m
//  YLWeiXinAppDylib
//
//  Created by wuyonglin on 2018/9/17.
//  Copyright (c) 2018年 IceCreamWu. All rights reserved.
//

#import "YLWeiXinAppDylib.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>
#import <MDCycriptManager.h>

CHConstructor{
    NSLog(INSERT_SUCCESS_WELCOME);
}


@interface WCUserComment

@property(nonatomic) unsigned int createTime; // @synthesize createTime;
@property(nonatomic) int type; // @synthesize type;
@property(nonatomic) int source; // @synthesize source;
@property(retain, nonatomic) NSString *content; // @synthesize content;
@property(retain, nonatomic) NSString *nickname; // @synthesize nickname;
@property(retain, nonatomic) NSString *username; // @synthesize username;
@property(retain, nonatomic) NSString *commentID; // @synthesize commentID;

@end



@interface WCDataItem

@property(retain, nonatomic) NSString *nickname;
@property(retain, nonatomic) NSString *username;
@property(retain, nonatomic) NSString *contentDesc;
@property(retain, nonatomic) NSMutableArray *likeUsers;
@property(nonatomic) int likeCount;

+ (id)fromServerObject:(id)arg1;

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



CHDeclareClass(WCDataItem)

CHOptimizedClassMethod1(self, id, WCDataItem, fromServerObject, id, serverObj){
    NSLog(@"hook WCDataItem fromServerObject");
    
    WCDataItem *dataItem = CHSuper1(WCDataItem, fromServerObject, serverObj);
    
    // 获取自己的信息
    id serviceCenter = [NSClassFromString(@"MMServiceCenter") defaultCenter];
    CContactMgr *contactMgr = [serviceCenter getService:NSClassFromString(@"CContactMgr")];
    CContact *selfContact = [contactMgr getSelfContact];
    
    // 是自己发的，并且包含X个赞的字符串才hook
    NSInteger hookLikeCount = 0;
    if ([dataItem.username isEqualToString:selfContact.m_nsUsrName]) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\d*个赞" options:NSRegularExpressionCaseInsensitive error:nil];
        NSString *desc = dataItem.contentDesc ?: @"";
        NSArray *matches = [regex matchesInString:desc options:0 range:NSMakeRange(0, desc.length)];
        if (matches.count > 0) {
            NSTextCheckingResult *result = [matches lastObject];
            NSString *matchStr = [desc substringWithRange:result.range];
            if (matchStr.length > 3) {
                NSString *numberStr = [matchStr substringWithRange:NSMakeRange(0, matchStr.length - 2)];
                if (numberStr.integerValue > 0) {
                    hookLikeCount = numberStr.integerValue;
                }
            }
        }
    }
    
    
    
    if (hookLikeCount) {
        
        hookLikeCount = hookLikeCount + arc4random() % 5;
        
        // 获取所有联系人信息(随机排序)
        NSArray *allContacts = [contactMgr getContactList:1 contactType:0];
        allContacts = [allContacts sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return arc4random() % 2 == 0 ? NSOrderedDescending : NSOrderedAscending;
        }];
        
        // 过滤联系人
        NSMutableArray<CContact *> *friends = [[NSMutableArray alloc] init];
        // 想让谁出现在点赞列表里面就修改这个数组
        NSArray *names = @[@"小明", @"小红", @"小妞"];
        for (CContact *contactItem in allContacts) {
            BOOL found = NO;
            for (NSString *targetName in names) {
                if ([contactItem.m_nsRemark containsString:targetName] || [contactItem.m_nsNickName containsString:targetName]) {
                    found = YES;
                    break;
                }
            }
            if (found) {
                [friends insertObject:contactItem atIndex:0];
            }
            else if ([contactItem isNormalFriendContact]) {
                [friends addObject:contactItem];
            }
        }
        
        // 添加点赞数据
        for (int i = 0; i < hookLikeCount; i++) {
            if (friends.count > i) {
                WCUserComment *copyItem = [[objc_getClass("WCUserComment") alloc] init];
                copyItem.createTime = [NSDate date].timeIntervalSince1970;
                copyItem.type = 1;
                copyItem.content = @"";
                copyItem.username = friends[i].m_nsUsrName;
                copyItem.nickname = friends[i].m_nsRemark ?: friends[i].m_nsNickName;
                [dataItem.likeUsers addObject:copyItem];
            }
        }
        dataItem.likeCount = (int)dataItem.likeUsers.count;
    }
    return dataItem;
}

CHConstructor{
    NSLog(@"hook WCDataItem");
    CHLoadLateClass(WCDataItem);
    CHClassHook1(WCDataItem, fromServerObject);
}

