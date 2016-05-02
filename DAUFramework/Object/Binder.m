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
#import "UIWrapper.h"

@implementation Binder


+ (id)binderWithObject:(nonnull id)sourceObject withScope:(nonnull NSString*)scope
{
    Binder * binder = [[ObjectManager shareInstance] getObject:sourceObject withScope:scope];
    if(binder == nil)
    {
        if([sourceObject isKindOfClass:[UIWrapper class]])
        {
            binder = [[UIWrapperActionBinder alloc] init];
        }
        else if([sourceObject isKindOfClass:[Data class]])
        {
            binder = [[DataUIWrapperBinder alloc] init];
        }
        else
        {
            binder = [[Binder alloc] init];
        }
        [[ObjectManager shareInstance] setObject:binder withKey:sourceObject withScope:scope];
    }
    return binder;
}
- (BOOL)doAction:(nonnull NSString*)condition withParam:(nullable Data*)param
{
    NSAssert(false, @"forbidden");
    return NO;
}

- (void)updateUI:(nonnull Data*)value
{
    NSAssert(false, @"forbidden");
}

- (BOOL)dataChanged:(nonnull NSString*)key
{
    NSAssert(false, @"forbidden");
    return NO;
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

@implementation UIWrapperActionBinder

- (BOOL)doAction:(NSString*)condition withParam:(nullable Data *)param
{
    BOOL result = YES;
    NSArray * actions = self[condition];
    for(UIAction * action in actions)
    {
        if(![action doAction:param])
        {
            result = NO;
        }
    }
    return result;
}

@end

@implementation DataUIWrapperBinder

- (void)updateUI:(nonnull Data*)value
{
    NSArray * uis = self[@"ui"];
    for(UIWrapper * ui in uis)
    {
        [ui updateUI];
    }
}

@end

