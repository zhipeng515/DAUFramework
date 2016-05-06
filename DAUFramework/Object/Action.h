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

+ (nonnull id)actionWithSelector:(nonnull SEL)selector withTarget:(nonnull id)target withParam:(nullable NSDictionary*)param;
+ (nonnull id)actionWithParam:(nonnull NSDictionary*)param;

- (void)packageSelector:(nonnull SEL)selector withTarget:(nonnull id)target;

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder;

- (nonnull id)copyWithZone:(nullable NSZone *)zone;
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone;

- (nonnull id)initWithParam:(nonnull NSDictionary*)param;
- (BOOL)doAction:(nullable Data*)param;

@end


