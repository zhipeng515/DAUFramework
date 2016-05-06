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
#import "DAUManager.h"


@implementation Data

+ (id)dataWithKey:(nonnull id)key withScope:(nonnull NSString*)scope
{
    Data * data = [[ObjectManager shareInstance] getObject:key withScope:scope];
    if(data == nil)
    {
        data = [[Data alloc] init];
        [[ObjectManager shareInstance] setObject:data withKey:key withScope:scope];
    }
    return data;
}

+ (void)dataCopy:(Data*)dest withSource:(Data*)source
{
    [source.propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        dest[key] = obj;
    }];
}

- (id)init
{
    if(self = [super init])
    {
        self.propertys = [[NSMutableDictionary alloc] init];
        [self.propertys setObject:[[NSMutableArray alloc] init] forKey:@"self.array"];
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.propertys forKey:@"dict"];
}

- (void)removeAllObjects
{
    [self.propertys removeAllObjects];
}

- (void)removeObjectForKey:(nonnull id)aKey
{
    [self.propertys removeObjectForKey:aKey];
}

- (nullable id)objectForKeyedSubscript:(nonnull id)key
{
    return [self.propertys objectForKeyedSubscript:key];
}

- (void)setObject:(nullable id)anObject forKeyedSubscript:(nonnull id <NSCopying>)aKey
{
    id oldObject = self.propertys[aKey];
    if([oldObject isEqual:anObject])
        return;
    [[DAUManager shareInstance] dataChanged:self withKey:aKey withObject:anObject];
    [self.propertys setObject:anObject forKeyedSubscript:aKey];
}

- (void)setValue:(nullable id)value forKey:(nonnull NSString *)key;
{
    id oldValue = self.propertys[key];
    if([oldValue isEqual:value])
        return;
    [[DAUManager shareInstance] dataChanged:self withKey:key withObject:value];
    [self.propertys setValue:value forKey:key];
}

- (void)setObject:(nonnull id)anObject forKey:(nonnull id <NSCopying>)aKey
{
    id oldObject = self.propertys[aKey];
    if([oldObject isEqual:anObject])
        return;
    [[DAUManager shareInstance] dataChanged:self withKey:aKey withObject:anObject];
    [self.propertys setObject:anObject forKey:aKey];
}

- (id)objectForKey:(id)aKey
{
    return [self.propertys objectForKey:aKey];
}

- (nullable NSEnumerator<id> *)objectEnumerator
{
    return [self.propertys objectEnumerator];
}

- (NSUInteger)countByEnumeratingWithState:(nullable NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len
{
    return [self.propertys countByEnumeratingWithState:state objects:buffer count:len];
}

- (nullable id)objectAtIndexedSubscript:(NSUInteger)idx
{
    NSMutableArray * array = [self.propertys objectForKey:@"self.array"];
    return array[idx];
}

- (void)setObject:(nullable id)obj atIndexedSubscript:(NSUInteger)idx
{
    NSMutableArray * array = [self.propertys objectForKey:@"self.array"];
    array[idx] = obj;
}

- (void)addObject:(nonnull id)anObject
{
    NSMutableArray * array = [self.propertys objectForKey:@"self.array"];
    [array addObject:anObject];
}

- (void)insertObject:(nonnull id)anObject atIndex:(NSUInteger)index
{
    NSMutableArray * array = [self.propertys objectForKey:@"self.array"];
    [array insertObject:anObject atIndex:index];
}

- (void)removeObjectAtIndex:(NSUInteger)index
{
    NSMutableArray * array = [self.propertys objectForKey:@"self.array"];
    [array removeObjectAtIndex:index];
}

- (nonnull NSString*)description
{
    NSString * desc = [JJRSObjectDescription descriptionForObject:self.propertys];
    return desc;
}

@end
