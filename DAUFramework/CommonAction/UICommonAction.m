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

- (void)textFieldDidEndEditing:(nonnull Data*)param
{
    UITextField * textField = param[@"textField"];
    NSLog(@"textField text %@", textField.text);
}

- (NSNumber*)textField_shouldChangeCharactersInRange_replacementString:(nonnull Data*)param
{
    UITextField * textField = param[@"textField"];
    NSRange range = NSRangeFromString(param[@"shouldChangeCharactersInRange"]);
    NSString * replacementString = param[@"replacementString"];
    return [NSNumber numberWithBool:YES];
}


@end
