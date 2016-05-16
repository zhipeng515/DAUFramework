//
//  UIModel.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Data.h"

@class Action;
@class UIWrapper;

@interface UIResponder (UIWrapper)

@property(nonatomic, retain, nonnull)UIWrapper * uiWrapper;

@end

@interface UIWrapper : Data

@property(nonatomic, nullable, weak)id ui;

+ (nonnull id)getUIObject:(nonnull id)key withScope:(nonnull NSString*)scope;
+ (nonnull id)getUIWrapper:(nonnull id)key withScope:(nonnull NSString*)scope;

- (nonnull id)getUIWrapper:(nonnull id)key withScope:(nonnull NSString*)scope;

- (nonnull id)copyWithZone:(nullable NSZone *)zone;
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone;

- (nonnull id)init:(nullable id)ui withScope:(nonnull NSString*)scope;


- (void)watchData:(nonnull Data*)data withKey:(nonnull NSString*)key;
- (void)watchData:(nonnull Data*)data withAction:(nullable Action*)action withKey:(nonnull NSString*)key,...NS_REQUIRES_NIL_TERMINATION;
- (void)unwatchData:(nonnull Data*)data withKey:(nonnull NSString*)key;

- (void)addAction:(nonnull id)target withSelector:(nonnull NSString*)selector withTrigger:(nonnull NSString*)trigger;
- (void)addAction:(nonnull Action*)action withTrigger:(nonnull NSString*)trigger;
- (void)removeAction:(nonnull NSString*)trigger;
- (void)removeAllActions;

- (nonnull NSString*)description;

- (void)onTap:(nonnull id)sender;

- (void)dataChanged:(nonnull id)value withKey:(nonnull NSString*)key;

@end
