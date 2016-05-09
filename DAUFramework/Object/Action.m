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

+ (id)actionWithSelector:(SEL)selector withTarget:(id)target withParam:(NSDictionary*)param
{
    Action * action = [[Action alloc] initWithParam:param];
    [action packageSelector:selector withTarget:target];
    return action;
}

+ (nonnull id)actionWithParam:(nonnull NSDictionary*)param
{
    id target = [[ObjectManager shareInstance] getObject:param[@"target"] withScope:GLOBAL_SCOPE];
    SEL selector = NSSelectorFromString(param[@"selector"]);
    return [self actionWithSelector:selector withTarget:target withParam:param];
}

-(id)initWithParam:(NSMutableDictionary*)param
{
    if(self = [super init])
    {
        [param enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            self[key] = obj;
        }];
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

- (void)packageSelector:(nonnull SEL)selector withTarget:(nonnull id)target
{
//    NSValue *selectorAsValue = [NSValue valueWithBytes:&selector objCType:@encode(SEL)];
//    self[@"selector"] = selectorAsValue;
    self[@"selector"] = NSStringFromSelector(selector);
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
    if(target && selector)
    {
        id result = [target performSelector:selector withObject:param];
        NSLog(@"%@", result);
    }
    return YES;
}

- (void)dealloc
{
    NSLog(@"Action dealloc <%@>", NSStringFromClass([self class]));
}

@end
