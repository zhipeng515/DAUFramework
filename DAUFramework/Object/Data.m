//
//  DAUCore.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "Data.h"
#import "ObjectManager.h"
#import "JJRSObjectDescription.h"

@implementation NSDictionary(MutableDeepCopy)

- (NSMutableDictionary *)mutableDeepCopy {
    NSMutableDictionary *ret = [[NSMutableDictionary alloc]
                                initWithCapacity:[self count]];
    NSArray *keys = [self allKeys];
    for (id key in keys) {
        id oneValue = [self valueForKey:key];
        id oneCopy = nil;
        if ([oneValue respondsToSelector:@selector(mutableDeepCopy)]) {
            oneCopy = [oneValue mutableDeepCopy];
        }
        else if ([oneValue respondsToSelector:@selector(mutableCopy)]) {
            oneCopy = [oneValue mutableCopy];
        }
        if (oneCopy == nil) {
            oneCopy = [oneValue copy];
        }
        [ret setValue:oneCopy forKey:key];
    }
    return ret;
}
@end


@implementation Data

- (id)init
{
    if([super init])
    {
        self.dict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.dict forKey:@"dict"];
}

- (nullable id)objectForKeyedSubscript:(nonnull id)key
{
    return [self.dict objectForKeyedSubscript:key];
}

- (void)removeAllObjects
{
    [self.dict removeAllObjects];
}

- (void)removeObjectForKey:(nonnull id)aKey
{
    [self.dict removeObjectForKey:aKey];
}

- (void)setValue:(nullable id)value forKey:(nonnull NSString *)key;
{
    id oldValue = self.dict[key];
    if([oldValue isEqual:value])
        return;
    [self.dict setValue:value forKey:key];
}

- (void)setObject:(nonnull id)anObject forKey:(nonnull id <NSCopying>)aKey
{
    id oldObject = self.dict[aKey];
    if([oldObject isEqual:anObject])
        return;
    [self.dict setObject:anObject forKey:aKey];
}

- (void)setObject:(nullable id)anObject forKeyedSubscript:(nonnull id <NSCopying>)aKey
{
    id oldObject = self.dict[aKey];
    if([oldObject isEqual:anObject])
        return;
    [self.dict setObject:anObject forKeyedSubscript:aKey];
}

- (id)objectForKey:(id)aKey
{
    return [self.dict objectForKey:aKey];
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    return self;
}

- (nonnull NSString*)description
{
    NSString * desc = [JJRSObjectDescription descriptionForObject:self.dict];
    return desc;
}

- (nullable NSEnumerator<id> *)objectEnumerator
{
    return [self.dict objectEnumerator];
}

+ (void)dataCopy:(Data*)dest withSource:(Data*)source
{
    [source.dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        dest[key] = obj;
    }];
}

@end
