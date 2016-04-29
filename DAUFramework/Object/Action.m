//
//  Action.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "Action.h"

@implementation Action

-(id)initWithParam:(NSMutableDictionary*)param
{
    if(self = [super init])
    {
        self.param = param;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone;
{
    return self;
}

-(void)encodeWithCoder:(nonnull NSCoder *)aCoder
{
    [aCoder encodeObject:self.param forKey:@"param"];
    [aCoder encodeObject:self.condition forKey:@"condition"];
    [aCoder encodeObject:self.param forKey:@"complete"];
    [aCoder encodeObject:self.param forKey:@"failed"];
}

-(void)doAction
{
    NSAssert(false, @"forbidden");
}

@end


@implementation HttpAction

-(id)initWithParam:(NSDictionary*)param
{
    if(self = [super initWithParam:param])
    {
    }
    return self;
}

-(void)doAction
{
}

@end

@implementation UIAction

-(id)initWithParam:(NSDictionary*)param
{
    if(self = [super initWithParam:param])
    {
    }
    return self;
}

-(void)doAction
{
}

@end

@implementation CustomAction

-(id)initWithParam:(NSDictionary*)param
{
    if(self = [super initWithParam:param])
    {
    }
    return self;
}

-(void)doAction
{
}

@end