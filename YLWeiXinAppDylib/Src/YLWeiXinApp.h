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

#endif /* YLWeiXinApp_h */
