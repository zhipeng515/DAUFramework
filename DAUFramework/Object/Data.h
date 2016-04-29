//
//  DAUCore.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject<NSCopying, NSMutableCopying>

@property(nonatomic, retain, nonnull) NSMutableDictionary * propertys;

+ (nonnull id)dataWithKey:(nonnull id)key withScope:(nonnull NSString*)scope;
+ (void)dataCopy:(nonnull Data*)dest withSource:(nonnull Data*)source;


- (nonnull id)copyWithZone:(nullable NSZone *)zone;
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone;

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder;

// 支持下标方法访问
- (nullable id)objectForKeyedSubscript:(nonnull id)key;

- (void)removeAllObjects;
- (void)removeObjectForKey:(nonnull id)aKey;

- (void)setValue:(nullable id)value forKey:(nonnull NSString *)key;
- (void)setObject:(nonnull id)anObject forKey:(nonnull id <NSCopying>)aKey;
- (void)setObject:(nullable id)anObject forKeyedSubscript:(nonnull id <NSCopying>)aKey;

- (nullable id)objectForKey:(nonnull id)aKey;
- (nullable NSEnumerator<id> *)objectEnumerator;
- (NSUInteger)countByEnumeratingWithState:(nullable NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len;

- (nonnull NSString*)description;

@end
