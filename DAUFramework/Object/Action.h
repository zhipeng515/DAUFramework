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

@property(nonatomic, retain, nonnull)NSMutableDictionary * param;
@property(nonatomic, retain, nullable)Action * complete;
@property(nonatomic, retain, nullable)Action * failed;

-(void)encodeWithCoder:(nonnull NSCoder *)aCoder;

- (nonnull id)copyWithZone:(nullable NSZone *)zone;
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone;

-(nonnull id)initWithParam:(nonnull NSDictionary*)param;
-(BOOL)doAction:(nullable Data*)param;

@end


@interface HttpAction : Action

-(nonnull id)initWithParam:(nonnull NSDictionary*)param;
-(BOOL)doAction:(nullable Data*)param;

@end

@interface UIAction : Action

-(nonnull id)initWithParam:(nonnull NSDictionary*)param;
-(BOOL)doAction:(nullable Data*)param;

@end

@interface DataAction : Action

-(nonnull id)initWithParam:(nonnull NSDictionary*)param;
-(BOOL)doAction:(nullable Data*)param;

@end

@interface CustomAction : Action

-(nonnull id)initWithParam:(nonnull NSDictionary*)param;
-(BOOL)doAction:(nullable Data*)param;

@end
