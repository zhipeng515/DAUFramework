//
//  Bind.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "Binder.h"
#import "ObjectManager.h"
#import "Action.h"

@implementation Binder

+ (id)binderWithObject:(nonnull id)sourceObject withScope:(nonnull NSString*)scope
{
    Binder * binder = [[ObjectManager shareInstance] getObject:sourceObject withScope:scope];
    if(binder == nil)
    {
        binder = [[Binder alloc] init];
        [[ObjectManager shareInstance] setObject:binder withKey:sourceObject withScope:scope];
    }
    return binder;
}

- (BOOL)doAction:(NSString*)condition
{
    BOOL result = YES;
    NSArray * actions = self[condition];
    for(UIAction * action in actions)
        [action doAction];
    return result;
}

- (void)setValue:(nullable id)value forKey:(nonnull NSString *)aKey;
{
    NSMutableArray * valueArray = self.propertys[aKey];
    if(valueArray == nil)
    {
        valueArray = [[NSMutableArray alloc] init];
        [self.propertys setObject:valueArray forKey:aKey];
    }
    [valueArray addObject:value];
}

- (void)setObject:(nonnull id)anObject forKey:(nonnull id <NSCopying>)aKey
{
    NSMutableArray * valueArray = self.propertys[aKey];
    if(valueArray == nil)
    {
        valueArray = [[NSMutableArray alloc] init];
        [self.propertys setObject:valueArray forKey:aKey];
    }
    [valueArray addObject:anObject];
}

- (void)setObject:(nullable id)anObject forKeyedSubscript:(nonnull id <NSCopying>)aKey
{
    NSMutableArray * valueArray = self.propertys[aKey];
    if(valueArray == nil)
    {
        valueArray = [[NSMutableArray alloc] init];
        [self.propertys setObject:valueArray forKeyedSubscript:aKey];
    }
    [valueArray addObject:anObject];
}

@end

