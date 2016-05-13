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
    if(selector != nil && target != nil )
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

- (BOOL)isEqual:(id)object
{
    if(![object isKindOfClass:[Action class]])
        return NO;
    
    Action * action = (Action*)object;
    if(![self.propertys isEqual:action.propertys])
        return NO;
    if(self.complete != action.complete && ![self.complete isEqual:action.complete])
        return NO;
    if(self.failed != action.failed && ![self.failed isEqual:action.failed])
        return NO;
    
    return YES;
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
    assert([target methodSignatureForSelector:NSSelectorFromString(selector)] != nil);

    self[@"selector"] = selector;
    self[@"target"] = target;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:self forKey:@"complete"];
    [aCoder encodeObject:self forKey:@"failed"];
}

- (id)doAction:(nullable Data*)param
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
//        IMP func = [target methodForSelector:selector];
//        func(target, selector, param);
        NSMethodSignature *signature = [target methodSignatureForSelector:selector];
        assert(signature != nil);
        if(signature)
        {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setTarget:target];
            [invocation setSelector:selector];
            [invocation setArgument:&param atIndex:2];
            [invocation invoke];
            
            if ([signature methodReturnLength]) {
                id data;
                [invocation getReturnValue:&data];
                return data;
            }
        }
    }
    
    return nil;
}

- (void)dealloc
{
    NSLog(@"Action dealloc <%@> %@ %@", NSStringFromClass([self class]), self[@"target"], self[@"selector"]);
}

@end
