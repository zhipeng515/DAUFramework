//
//  DAUManager.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "DAUManager.h"
#import "Binder.h"
#import "ModelManager.h"
#import "DataCore.h"
#import "UIModel.h"

@implementation DAUManager

+(DAUManager*)shareInstance
{
    static DAUManager * instance = nil;
    if(instance == nil)
        instance = [[DAUManager alloc]init];
    return instance;
}

-(id)init
{
    if(self = [super init])
    {
        self.binders = [[NSMutableDictionary alloc] init];
    }
    return self;
}


-(void)bindObject:(id)src withOtherObject:(id)dest
{
    if([src isKindOfClass:[UIModel class]] && [dest isKindOfClass:[DataCore class]])
    {
        ViewDataBinder * viewDataBinder = [[ModelManager shareInstance] createModel:@{@"src":src, @"dest":dest} withKey:@"createViewDataBind"];
        [[ModelManager shareInstance] setModel:viewDataBinder withKey:src];
    }
}

-(void)trigger:(id)src
{
    id binder = [[ModelManager shareInstance] getModel:src];
    if(binder == nil)
    {
        NSAssert(![binder isKindOfClass:[Binder class]], @"object %@ class is not a Binder", src);
        return;
    }
    [binder trigger];
}

@end
