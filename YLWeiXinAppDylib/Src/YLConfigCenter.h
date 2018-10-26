//
//  YLConfigCenter.h
//  YLWeiXinAppDylib
//
//  Created by wuyonglin on 2018/10/25.
//  Copyright © 2018年 IceCreamWu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLConfigCenter : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, assign) BOOL hookLike;
@property (nonatomic, assign) BOOL hookDice;
@property (nonatomic, assign) BOOL hookMorra;
@property (nonatomic, assign) NSInteger stepCount;
@property (nonatomic, strong) NSDate *stepCountChangeDate;

@end

NS_ASSUME_NONNULL_END
