//
//  UICommonAction.m
//  DAUFramework
//
//  Created by zhipeng on 16/5/12.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "UICommonAction.h"
#import "Data.h"
#import "UIWrapper.h"
#import "Binder.h"
#import "DAUManager.h"
#import "DAUViewController.h"

@implementation UICommonAction


+ (nullable NSString*)objectToUpdateSelector:(nonnull id)object
{
    NSString * selector = nil;
    if([object isKindOfClass:[UIButton class]])
        selector = @"updateButtonTitle:";
    else if([object isKindOfClass:[UILabel class]])
        selector = @"updateLabelText:";
    else if([object isKindOfClass:[UITextField class]])
        selector = @"updateTextFieldText:";
    else if([object isKindOfClass:[UILabel class]])
        selector = @"updateImageViewImage:";
    
    return selector;
}

+ (void)loadLayoutFromJson:(Data*)value
{
    //根据json文件加载页面布局
    DAUViewController * viewController = value[@"self"];
    NSDictionary * jsonDic = [DAUManager getDictionaryFromJsonFile:viewController.controllerName];
    NSArray * layoutInfo = [DAUManager parseLayoutModel:[jsonDic objectForKey:@"layoutInfo"] withParent:nil withScope:viewController.uiWrapper.scope];
    [DAUManager createLayoutModel:layoutInfo withParent:viewController.uiWrapper];
}

+ (void)defaultNavigationControllerViewWillAppear:(Data*)value
{
    [DAUManager shareInstance].currentNaviController = value[@"self"];
}

+ (void)updateButtonTitle:(Data*)value
{
    UIWrapper * uiWrapper = value[@"self"];
    id title = value[@"value"];
    assert([uiWrapper.ui isKindOfClass:[UIButton class]]);
    [uiWrapper.ui setTitle:title forState:UIControlStateNormal];
}

+ (void)updateLabelText:(nonnull Data*)value
{
    UIWrapper * uiWrapper = value[@"self"];
    id title = value[@"value"];
    assert([uiWrapper.ui isKindOfClass:[UILabel class]]);
    [uiWrapper.ui setText:title];
}

+ (void)updateTextFieldText:(nonnull Data*)value
{
    UIWrapper * uiWrapper = value[@"self"];
    id text = value[@"value"];
    assert([uiWrapper.ui isKindOfClass:[UITextField class]]);
    [uiWrapper.ui setText:text];
}

+ (void)updateImageViewImage:(nonnull Data*)value
{
    UIWrapper * uiWrapper = value[@"self"];
    id image = value[@"value"];
    assert([uiWrapper.ui isKindOfClass:[UIImageView class]]);
    [uiWrapper.ui setImage:image];
}


#pragma mark CONTROLLER

+ (void)loadView:(nonnull UIResponder*)controller
{
    Binder * binder = [Binder getBinder:controller.uiWrapper withScope:controller.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:controller.uiWrapper.scope];
    param[@"self"] = controller;
    [binder doAction:@"loadView" withParam:param];
}

+ (void)viewDidLoad:(nonnull UIResponder*)controller
{
    // Do any additional setup after loading the view.
    Binder * binder = [Binder getBinder:controller.uiWrapper withScope:controller.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:controller.uiWrapper.scope];
    param[@"self"] = controller;
    [binder doAction:@"viewDidLoad" withParam:param];
}

+ (void)viewWillAppear:(BOOL)animated withController:(nonnull UIResponder*)controller
{
    Binder * binder = [Binder getBinder:controller.uiWrapper withScope:controller.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:controller.uiWrapper.scope];
    param[@"self"] = controller;
    param[@"animated"] = [NSNumber numberWithBool:animated];
    [binder doAction:@"viewWillAppear" withParam:param];
}

+ (void)viewDidAppear:(BOOL)animated withController:(nonnull UIResponder*)controller
{
    Binder * binder = [Binder getBinder:controller.uiWrapper withScope:controller.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:controller.uiWrapper.scope];
    param[@"self"] = controller;
    param[@"animated"] = [NSNumber numberWithBool:animated];
    [binder doAction:@"viewDidAppear" withParam:param];
}

+ (void)viewWillDisappear:(BOOL)animated withController:(nonnull UIResponder*)controller
{
    Binder * binder = [Binder getBinder:controller.uiWrapper withScope:controller.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:controller.uiWrapper.scope];
    param[@"self"] = controller;
    param[@"animated"] = [NSNumber numberWithBool:animated];
    [binder doAction:@"viewWillDisappear" withParam:param];
}

+ (void)viewDidDisappear:(BOOL)animated withController:(nonnull UIResponder*)controller
{
    Binder * binder = [Binder getBinder:controller.uiWrapper withScope:controller.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:controller.uiWrapper.scope];
    param[@"self"] = controller;
    param[@"animated"] = [NSNumber numberWithBool:animated];
    [binder doAction:@"viewDidDisappear" withParam:param];
}

// Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
+ (void)viewWillLayoutSubviews:(nonnull UIResponder*)controller
{
    Binder * binder = [Binder getBinder:controller.uiWrapper withScope:controller.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:controller.uiWrapper.scope];
    param[@"self"] = controller;
    [binder doAction:@"viewWillLayoutSubviews" withParam:param];
}

// Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
+ (void)viewDidLayoutSubviews:(nonnull UIResponder*)controller
{
    Binder * binder = [Binder getBinder:controller.uiWrapper withScope:controller.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:controller.uiWrapper.scope];
    param[@"self"] = controller;
    [binder doAction:@"viewDidLayoutSubviews" withParam:param];
}


+ (BOOL)shouldAutorotate:(nonnull UIResponder*)controller
{
    Binder * binder = [Binder getBinder:controller.uiWrapper withScope:controller.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return FALSE;
    Data * param = [[Data alloc] initWithScope:controller.uiWrapper.scope];
    param[@"self"] = controller;
    id retValue = [binder doAction:@"shouldAutorotate" withParam:param];
    if([retValue isKindOfClass:[NSNumber class]])
        return [retValue boolValue];
    return FALSE;
}

+ (UIInterfaceOrientationMask)supportedInterfaceOrientations:(nonnull UIResponder*)controller
{
    Binder * binder = [Binder getBinder:controller.uiWrapper withScope:controller.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return UIInterfaceOrientationMaskPortrait;
    Data * param = [[Data alloc] initWithScope:controller.uiWrapper.scope];
    param[@"self"] = controller;
    id retValue = [binder doAction:@"supportedInterfaceOrientations" withParam:param];
    if([retValue isKindOfClass:[NSNumber class]])
        return [retValue integerValue];
    return UIInterfaceOrientationMaskPortrait;
}

// Returns interface orientation masks.
+ (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation:(nonnull UIResponder*)controller
{
    Binder * binder = [Binder getBinder:controller.uiWrapper withScope:controller.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return UIInterfaceOrientationPortrait;
    Data * param = [[Data alloc] initWithScope:controller.uiWrapper.scope];
    param[@"self"] = controller;
    id retValue = [binder doAction:@"preferredInterfaceOrientationForPresentation" withParam:param];
    if([retValue isKindOfClass:[NSNumber class]])
        return [retValue integerValue];
    return UIInterfaceOrientationPortrait;
}

+ (void)didReceiveMemoryWarning:(nonnull UIResponder*)controller
{
    // Dispose of any resources that can be recreated.
    Binder * binder = [Binder getBinder:controller.uiWrapper withScope:controller.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:controller.uiWrapper.scope];
    param[@"self"] = controller;
    [binder doAction:@"didReceiveMemoryWarning" withParam:param];
}



@end
