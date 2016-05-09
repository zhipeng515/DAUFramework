//
//  UIModel.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Data;
@class Action;

@interface UIResponder (UIWrapper)

@property(nonatomic, retain, nonnull)id uiWrapper;

@end

@interface UIWrapper : NSObject<NSCopying, NSMutableCopying, UITextFieldDelegate>

@property(nonatomic, retain, nonnull)id ui;

- (nonnull id)copyWithZone:(nullable NSZone *)zone;
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone;

- (nonnull id)initWithUI:(nullable id)ui;
- (void)watchData:(nonnull Data*)data withKey:(nonnull NSString*)key withAction:(nullable Action*)action;
- (void)addAction:(nonnull Action*)action withTrigger:(nonnull NSString*)trigger;

- (nonnull NSString*)description;

- (void)onTap:(nonnull id)sender;

- (void)updateUI:(nonnull id)value;

@end
