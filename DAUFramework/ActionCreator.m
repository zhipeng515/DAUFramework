//
//  ActionCreator.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "ActionCreator.h"
#import "Action.h"

@implementation ActionCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    NSAssert(false, @"forbidden");
    return nil;
}


@end


@implementation HttpActionCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    HttpAction * http = [[HttpAction alloc]initWithParam:dict];
    return http;
}


@end


@implementation UIActionCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    UIAction * ui = [[UIAction alloc]initWithParam:dict];
    return ui;
}


@end


@implementation DataActionCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    return nil;
}


@end


@implementation CustomActionCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    CustomAction * custom = [[CustomAction alloc] initWithParam:dict];
    return custom;
}


@end