//
//  UIModel.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "UIWrapper.h"
#import "JJRSObjectDescription.h"
#import "ObjectManager.h"
#import "Action.h"
#import "Binder.h"
#import <objc/runtime.h>

@implementation UIResponder (UIWrapper)

- (id)uiWrapper {
    return objc_getAssociatedObject(self, @selector(uiWrapper));
}

- (void)setUiWrapper:(id)uiWrapper {
    objc_setAssociatedObject(self, @selector(uiWrapper), uiWrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIWrapper

-(id)initWithUI:(id)ui
{
    if(self = [super init])
    {
        self.ui = ui;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone;
{
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.ui forKey:@"ui"];
}

- (nonnull NSString*)description
{
    NSString * desc = [JJRSObjectDescription descriptionForObject:self.ui];
    return desc;
}

///////////////////////////////////////////////////////////////////////////////////////////
// UIButton
- (void)onTap:(nonnull id)sender
{
    Binder * binder = [Binder binderWithObject:self withScope:GLOBAL_SCOPE];
    [binder doAction:@"onTap"];
}
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////
// UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    Binder * binder = [Binder binderWithObject:self withScope:GLOBAL_SCOPE];
    if([binder doAction:@"textFieldShouldBeginEditing"])
        return NO;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    Binder * binder = [Binder binderWithObject:self withScope:GLOBAL_SCOPE];
    [binder doAction:@"textFieldDidBeginEditing"];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    Binder * binder = [Binder binderWithObject:self withScope:GLOBAL_SCOPE];
    if([binder doAction:@"textFieldShouldEndEditing"])
        return NO;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    Binder * binder = [Binder binderWithObject:self withScope:GLOBAL_SCOPE];
    [binder doAction:@"textFieldDidEndEditing"];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}


@end
