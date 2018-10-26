//
//  YLHookStep.m
//  YLWeiXinAppDylib
//
//  Created by wuyonglin on 2018/10/25.
//  Copyright © 2018年 IceCreamWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CaptainHook/CaptainHook.h>
#import "YLWeiXinApp.h"
#import "YLConfigCenter.h"

CHDeclareClass(WCDeviceStepObject)

CHOptimizedMethod0(self, unsigned int, WCDeviceStepObject, m7StepCount)
{
    return CHSuper0(WCDeviceStepObject, m7StepCount);
}

CHConstructor{
    NSLog(@"YLHook WCDeviceStepObject");
    CHLoadLateClass(WCDeviceStepObject);
    CHHook0(WCDeviceStepObject, m7StepCount);
}
