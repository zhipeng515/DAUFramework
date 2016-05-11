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
            binder = [[UIWrapperActionBinder alloc] initWithScope:scope];
        }
        else if([sourceObject isKindOfClass:[Data class]])
        {
            binder = [[DataUIWrapperBinder alloc] initWithScope:scope];
        }
        else
        {
            binder = [[Binder alloc] initWithScope:scope];
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

- (void)removeObject:(nonnull id)anObject forKey:(nonnull id)aKey
{
    NSMutableArray * valueArray = self.propertys[aKey];
    if(valueArray == nil)
        return;
    [valueArray removeObject:anObject];
}

- (void)dealloc
{
    NSLog(@"Binder dealloc <%@>", NSStringFromClass([self class]));
}


@end

@implementation UIWrapperActionBinder

- (id)doAction:(NSString*)condition withParam:(nullable Data *)param
{
    NSMutableArray * resultArray = [[NSMutableArray alloc] init];
    NSArray * actions = self[condition];
    for(id action in actions)
    {
        if(![action isKindOfClass:[Action class]])
            continue;
        id result = [action doAction:param];
        if(result != nil)
        {
            [resultArray addObject:result];
        }
    }
    return resultArray;
}


- (void)dealloc
{
    // 释放绑定到数据上面的UI组件
    [self.propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSArray * valueArray = (NSArray*)obj;
        for(id value in valueArray)
        {
            Data * data = (Data*)value;
            Binder * binder = [Binder binderWithObject:data withScope:data.scope];
            NSArray * uis = binder[key];
            for(UIWrapper * ui in uis)
                [binder removeObject:ui forKey:key];
        }
//        NSLog(@"UIWrapperActionBinder dealloc<%@>=<%@>", key, obj);
    }];
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
