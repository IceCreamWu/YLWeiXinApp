//
//  YLConfigCenter.m
//  YLWeiXinAppDylib
//
//  Created by wuyonglin on 2018/10/25.
//  Copyright © 2018年 IceCreamWu. All rights reserved.
//

#import "YLConfigCenter.h"
#import "YLGlobalDefine.h"
#import <objc/runtime.h>

@implementation YLConfigCenter

LSERIALIZE_CODER_DECODER()

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static YLConfigCenter *configCenter;
    dispatch_once(&onceToken, ^{
        configCenter = [[YLConfigCenter alloc] initInstance];
    });
    return configCenter;
}

- (instancetype)initInstance {
    self = [super init];
    if (self) {
        
        
        
    }
    return self;
}

@end
