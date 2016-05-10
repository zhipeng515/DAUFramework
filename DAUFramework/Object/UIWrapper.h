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

@interface UIResponder (UIWrapper)

@property(nonatomic, retain, nonnull)id uiWrapper;

@end

@interface UIWrapper : Data<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, nullable, weak)id ui;

+ (nonnull id)getUIObject:(nonnull id)key withScope:(nonnull NSString*)scope;
+ (nonnull id)getUIWrapper:(nonnull id)key withScope:(nonnull NSString*)scope;

- (nonnull id)copyWithZone:(nullable NSZone *)zone;
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone;

- (nonnull id)initWithUI:(nullable id)ui;



- (void)watchData:(nonnull Data*)data withKey:(nonnull NSString*)key withAction:(nullable Action*)action withScope:(nonnull NSString*)scope;
- (void)addAction:(nonnull Action*)action withTrigger:(nonnull NSString*)trigger withScope:(nonnull NSString*)scope;

- (nonnull NSString*)description;

- (void)onTap:(nonnull id)sender;

- (void)dataChanged:(nonnull id)value;

@end
