//
//  Action.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"

@interface Action : Data

@property(nonatomic, retain, nullable)Action * complete;
@property(nonatomic, retain, nullable)Action * failed;

+ (nonnull id)actionWithSelector:(nonnull NSString*)selector withTarget:(nonnull id)target withParam:(nullable NSDictionary*)param withScope:(nonnull NSString*)scope;
+ (nonnull id)actionWithParam:(nonnull NSDictionary*)param withScope:(nonnull NSString*)scope;

- (void)packageSelector:(nonnull NSString*)selector withTarget:(nonnull id)target;

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder;

- (nonnull id)copyWithZone:(nullable NSZone *)zone;
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone;

- (nonnull id)init:(nonnull NSDictionary*)param withScope:(nonnull NSString*)scope;
- (nullable id)doAction:(nullable Data*)param;

@end


