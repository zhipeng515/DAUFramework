//
//  ActionCreator.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "ActionCreator.h"
#import "Action.h"
#import "ObjectManager.h"

@implementation ActionCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    Action * action = [Action actionWithParam:dict];
    [[ObjectManager shareInstance] setObject:action withKey:key withScope:GLOBAL_SCOPE];
    return action;
}


@end
