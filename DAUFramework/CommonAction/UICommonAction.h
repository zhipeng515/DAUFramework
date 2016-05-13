//
//  UICommonAction.h
//  DAUFramework
//
//  Created by zhipeng on 16/5/12.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonAction.h"

@class Data;

@interface UICommonAction : CommonAction

+ (nonnull id)shareInstance;

- (nullable NSString*)objectToUpdateSelector:(nonnull id)object;

- (void)viewControllerLoadView:(nonnull Data*)value;

- (void)updateButtonTitle:(nonnull Data*)value;
- (void)updateLabelText:(nonnull Data*)value;
- (void)updateTextFieldText:(nonnull Data*)value;
- (void)updateImageViewImage:(nonnull Data*)value;

@end