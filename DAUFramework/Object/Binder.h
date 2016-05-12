//
//  Bind.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"

@interface Binder : Data

+ (nonnull id)binderWithObject:(nonnull id)sourceObject withScope:(nonnull NSString*)scope;
+ (nullable id)getBinder:(nonnull id)sourceObject withScope:(nonnull NSString *)scope;

- (nullable id)doAction:(nonnull NSString*)condition withParam:(nullable Data*)param;
- (void)dataChanged:(nonnull Data*)data withKey:(nonnull id)key withValue:(nonnull id)value;

- (void)removeObject:(nonnull id)anObject;
- (void)removeObjectsForKey:(nonnull id)aKey;
- (void)removeObject:(nonnull id)anObject forKey:(nonnull id)aKey;

- (BOOL)hasBinded:(nonnull id)anObject forKey:(nonnull id)aKey;

@end

@interface UIWrapperActionBinder : Binder

- (nullable id)doAction:(nonnull NSString*)condition withParam:(nullable Data*)param;

@end

@interface DataUIWrapperBinder : Binder

- (void)dataChanged:(nonnull Data*)data withKey:(nonnull id)key withValue:(nonnull id)value;

@end
