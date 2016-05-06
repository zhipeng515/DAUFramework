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

- (void)watchData:(nonnull Data*)data withKey:(nonnull NSString*)key
{
    Binder * binder = [Binder binderWithObject:data withScope:GLOBAL_SCOPE];
    binder[key] = self;
}

- (void)addAction:(nonnull Action*)action withTrigger:(NSString*)trigger
{
    Binder * binder = [Binder binderWithObject:self withScope:GLOBAL_SCOPE];
    binder[trigger] = action;
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

- (void)updateUI:(nonnull id)value
{
    NSLog(@"data changed %@", value);
}

///////////////////////////////////////////////////////////////////////////////////////////
// UIButton
- (void)onTap:(nonnull id)sender
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    Data * param = [[Data alloc] init];
    param[@"sender"] = sender;
    [binder doAction:@"onTap" withParam:param];
}
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////
// UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    return [binder doAction:@"textFieldShouldBeginEditing" withParam:param];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    [binder doAction:@"textFieldDidBeginEditing" withParam:param];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    return [binder doAction:@"textFieldShouldEndEditing" withParam:param];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    [binder doAction:@"textFieldDidEndEditing" withParam:param];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    param[@"shouldChangeCharactersInRange"] = NSStringFromRange(range);
    param[@"replacementString"] = string;
    return [binder doAction:@"textField:shouldChangeCharactersInRange:replacementString" withParam:param];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    return [binder doAction:@"textFieldShouldClear" withParam:param];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    return [binder doAction:@"textFieldShouldReturn" withParam:param];
}


@end
