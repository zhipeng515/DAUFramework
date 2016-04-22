//
//  BindCreator.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "BinderCreator.h"
#import "Binder.h"

@implementation BinderCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    return nil;
}


@end


@implementation ViewDataBinderCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    ViewDataBinder * viewDataBinder = [[ViewDataBinder alloc] init];
    [viewDataBinder bindObject:dict[@"src"] withOtherObject:dict[@"dest"]];
    return viewDataBinder;
}


@end