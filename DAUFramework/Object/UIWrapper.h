//
//  UIModel.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIResponder (UIWrapper)

@property(nonatomic, retain, nonnull)id uiWrapper;

@end

@interface UIWrapper : NSObject<NSCopying, NSMutableCopying, UITextFieldDelegate>

@property(nonatomic, retain, nonnull)id ui;

- (nonnull id)copyWithZone:(nullable NSZone *)zone;
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone;

- (nonnull id)initWithUI:(nullable id)ui;

- (nonnull NSString*)description;

- (void)onTap:(nonnull id)sender;

@end
