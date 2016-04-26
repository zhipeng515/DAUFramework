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