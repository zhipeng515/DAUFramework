//
//  Bind.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "Binder.h"

@implementation Binder

-(void)bindObject:(id)src withOtherObject:(id)dest
{
    NSAssert(false, @"forbidden");
}

@end

@implementation ViewDataBind

-(id)init
{
    if([super init])
    {
        self.views = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)bindObject:(id)src withOtherObject:(id)dest
{
    
}

@end
