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
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self.param forKey:@"param"];
    [aCoder encodeObject:self.param forKey:@"complete"];
    [aCoder encodeObject:self.param forKey:@"failed"];
}

-(BOOL)doAction:(nullable Data*)param
{
    NSAssert(false, @"forbidden");
    return YES;
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

-(BOOL)doAction:(nullable Data*)param
{
    return YES;
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

-(BOOL)doAction:(nullable Data*)param
{
    NSLog(@"ui action run");
    return YES;
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

-(BOOL)doAction:(nullable Data*)param
{
    NSLog(@"custom action run");
    return YES;
}

@end