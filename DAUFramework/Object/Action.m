//
//  Action.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "Action.h"
#import "ObjectManager.h"
#import "DAUViewController.h"

@implementation Action

+ (id)actionWithSelector:(NSString*)selector withTarget:(id)target withParam:(NSDictionary*)param withScope:(NSString*)scope
{
    Action * action = [[Action alloc] init:param withScope:scope];
    [action packageSelector:selector withTarget:target];
    return action;
}

+ (nonnull id)actionWithParam:(nonnull NSDictionary*)param withScope:(NSString*)scope
{
    id target = [[ObjectManager shareInstance] getObject:param[@"target"] withScope:scope];
    return [self actionWithSelector:param[@"selector"] withTarget:target withParam:param withScope:scope];
}

-(id)init:(NSMutableDictionary*)param withScope:(NSString*)scope
{
    if(self = [super initWithScope:scope])
    {
        [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            self[key] = obj;
        }];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone;
{
    return self;
}

- (void)packageSelector:(NSString*)selector withTarget:(nonnull id)target
{
//    NSValue *selectorAsValue = [NSValue valueWithBytes:&selector objCType:@encode(SEL)];
//    self[@"selector"] = selectorAsValue;
    self[@"selector"] = selector;
    self[@"target"] = target;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self forKey:@"complete"];
    [aCoder encodeObject:self forKey:@"failed"];
}

- (BOOL)doAction:(nullable Data*)param
{
//    NSValue * selectorValue = self[@"selector"];
//    if(selectorValue)
//    {
//        SEL selector;
//        [selectorValue getValue:&selector];
//        id target = self[@"target"];
//        if(target && selector)
//        {
//            id result = [target performSelector:selector withObject:self];
//            NSLog(@"%@", result);
//        }
//    }
    id target = self[@"target"];
    SEL selector = NSSelectorFromString(self[@"selector"]);
    if(target && selector && [target respondsToSelector:selector])
    {
        [target performSelector:selector withObject:param];
//        id result = [target performSelector:selector withObject:param];
//        NSLog(@"%@", result);
    }
    return YES;
}

- (void)dealloc
{
//    NSLog(@"Action dealloc <%@>", NSStringFromClass([self class]));
}

@end
