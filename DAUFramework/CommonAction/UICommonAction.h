//
//  UICommonAction.h
//  DAUFramework
//
//  Created by zhipeng on 16/5/12.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommonAction.h"

@class Data;

@interface UICommonAction : CommonAction

+ (nullable NSString*)objectToUpdateSelector:(nonnull id)object;

+ (void)loadLayoutFromJson:(nonnull Data*)value;
+ (void)defaultNavigationControllerViewWillAppear:(nonnull Data*)value;

+ (void)updateButtonTitle:(nonnull Data*)value;
+ (void)updateLabelText:(nonnull Data*)value;
+ (void)updateTextFieldText:(nonnull Data*)value;
+ (void)updateImageViewImage:(nonnull Data*)value;



+ (void)loadView:(nonnull UIResponder*)controller;
+ (void)viewDidLoad:(nonnull UIResponder*)controller;
+ (void)viewWillAppear:(BOOL)animated withController:(nonnull UIResponder*)controller;
+ (void)viewDidAppear:(BOOL)animated withController:(nonnull UIResponder*)controller;
+ (void)viewWillDisappear:(BOOL)animated withController:(nonnull UIResponder*)controller;
+ (void)viewDidDisappear:(BOOL)animated withController:(nonnull UIResponder*)controller;
+ (void)viewWillLayoutSubviews:(nonnull UIResponder*)controller;
+ (void)viewDidLayoutSubviews:(nonnull UIResponder*)controller;
+ (BOOL)shouldAutorotate:(nonnull UIResponder*)controller;
+ (UIInterfaceOrientationMask)supportedInterfaceOrientations:(nonnull UIResponder*)controller;
+ (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation:(nonnull UIResponder*)controller;
+ (void)didReceiveMemoryWarning:(nonnull UIResponder*)controller;

@end
