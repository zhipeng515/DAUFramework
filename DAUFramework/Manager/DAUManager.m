//
//  DAUManager.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "DAUManager.h"
#import "Binder.h"
#import "ObjectManager.h"
#import "Data.h"
#import "UI.h"

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

-(void)buildModel:(NSDictionary*)dict
{
    for (NSString * modelName in dict) {
		NSDictionary * modelDict = dict[modelName];
		NSString * creatorName = modelDict[@"creator"];
		NSDictionary * property = modelDict[@"property"];
        NSAssert(creatorName != nil, @"creator name is nil");
        NSAssert(property != nil, @"property is nil");

        id modelValue = [[ObjectManager shareInstance] createObject:property withKey:creatorName];
		[[ObjectManager shareInstance] setObject:modelValue withKey:modelName];
	}
}

-(void)bindObject:(id)src withOtherObject:(id)dest
{
    if([src isKindOfClass:[UI class]] && [dest isKindOfClass:[Data class]])
    {
        ViewDataBinder * viewDataBinder = [[ObjectManager shareInstance] createObject:@{@"src":src, @"dest":dest} withKey:@"createViewDataBind"];
        [[ObjectManager shareInstance] setObject:viewDataBinder withKey:src];
    }
}

-(void)trigger:(id)src
{
    id binder = [[ObjectManager shareInstance] getObject:src];
    if(binder == nil)
    {
        NSAssert(![binder isKindOfClass:[Binder class]], @"object %@ class is not a Binder", src);
        return;
    }
    [binder trigger];
}

@end
