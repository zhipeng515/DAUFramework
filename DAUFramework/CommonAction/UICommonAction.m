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
#import "DAUManager.h"
#import "DAUViewController.h"

@implementation UICommonAction

+ (id)shareInstance
{
    static UICommonAction * commonAction = nil;
    if(commonAction == nil)
        commonAction = [[UICommonAction alloc] init];
    
    return commonAction;
}


- (nullable NSString*)objectToUpdateSelector:(nonnull id)object
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

- (void)viewControllerLoadView:(Data*)value
{
    //根据json文件加载页面布局
    DAUViewController * viewController = value[@"self"];
    NSDictionary * jsonDic = [[DAUManager shareInstance] getDictionaryFromJsonFile:viewController.controllerName];
    NSArray * layoutInfo = [[DAUManager shareInstance] parseLayoutModel:[jsonDic objectForKey:@"layoutInfo"] withParent:nil withScope:viewController.uiWrapper.scope];
    [[DAUManager shareInstance] createLayoutModel:layoutInfo withParent:viewController.uiWrapper];
}

- (void)updateButtonTitle:(Data*)value
{
    UIWrapper * uiWrapper = value[@"self"];
    id title = value[@"value"];
    assert([uiWrapper.ui isKindOfClass:[UIButton class]]);
    [uiWrapper.ui setTitle:title forState:UIControlStateNormal];
}

- (void)updateLabelText:(nonnull Data*)value
{
    UIWrapper * uiWrapper = value[@"self"];
    id title = value[@"value"];
    assert([uiWrapper.ui isKindOfClass:[UILabel class]]);
    [uiWrapper.ui setText:title];
}

- (void)updateTextFieldText:(nonnull Data*)value
{
    UIWrapper * uiWrapper = value[@"self"];
    id text = value[@"value"];
    assert([uiWrapper.ui isKindOfClass:[UITextField class]]);
    [uiWrapper.ui setText:text];
}

- (void)updateImageViewImage:(nonnull Data*)value
{
    UIWrapper * uiWrapper = value[@"self"];
    id image = value[@"value"];
    assert([uiWrapper.ui isKindOfClass:[UIImageView class]]);
    [uiWrapper.ui setImage:image];
}

@end
