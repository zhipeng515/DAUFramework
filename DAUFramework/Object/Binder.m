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

+ (nullable id)getBinder:(nonnull id)sourceObject withScope:(nonnull NSString *)scope
{
    Binder * binder = [[ObjectManager shareInstance] getObject:sourceObject withScope:scope];
    return binder;
}

- (id)doAction:(nonnull NSString*)condition withParam:(nullable Data*)param
{
    NSAssert(false, @"forbidden");
    return nil;
}

- (void)dataChanged:(nonnull Data*)data withKey:(nonnull id)key withValue:(nonnull id)value
{
    NSAssert(false, @"forbidden");
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

- (void)dealloc
{
//    NSLog(@"Binder dealloc <%@>", NSStringFromClass([self class]));
}


@end

@implementation UIWrapperActionBinder

- (id)doAction:(NSString*)condition withParam:(nullable Data *)param
{
    BOOL result = YES;
    NSArray * actions = self[condition];
    for(Action * action in actions)
    {
        if(![action doAction:param])
        {
            result = NO;
        }
    }
    return [NSNumber numberWithBool:result];
}

@end

@implementation DataUIWrapperBinder

- (void)dataChanged:(nonnull Data*)data withKey:(nonnull id)key withValue:(nonnull id)value;
{
    NSArray * uis = self[key];
    for(UIWrapper * ui in uis)
    {
        [ui dataChanged:value];
    }
}

@end
