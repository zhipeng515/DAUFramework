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

+ (nonnull id)getUIObject:(nonnull id)key withScope:(nonnull NSString*)scope
{
    UIWrapper * uiWrapper = [[ObjectManager shareInstance] getObject:key withScope:scope];
    return uiWrapper.ui;
}

+ (nonnull id)getUIWrapper:(nonnull id)key withScope:(nonnull NSString*)scope
{
    return [[ObjectManager shareInstance] getObject:key withScope:scope];
}


-(id)init:(id)ui withScope:(NSString *)scope
{
    if(self = [super initWithScope:scope])
    {
        self.ui = ui;
    }
    return self;
}

- (void)watchData:(nonnull Data*)data withKey:(nonnull NSString*)key withAction:(Action*)action
{
    Binder * binder = [Binder binderWithObject:data withScope:GLOBAL_SCOPE];
    binder[key] = self;
    if(action)
        [self addAction:action withTrigger:@"dataSourceChanged"];
}

- (void)addAction:(nonnull Action*)action withTrigger:(NSString*)trigger
{
    Binder * binder = [Binder binderWithObject:self withScope:self.scope];
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

- (void)dealloc
{
    NSLog(@"UIWrapper dealloc <%@>", NSStringFromClass([self.ui class]));
}


- (void)dataChanged:(nonnull id)value
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"value"] = value;
    [binder doAction:@"dataSourceChanged" withParam:param];
}

///////////////////////////////////////////////////////////////////////////////////////////
// UIButton
- (void)onTap:(nonnull id)sender
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(binder == nil)
        return;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"sender"] = sender;
    [binder doAction:@"onTap" withParam:param];
}
///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////
// UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(binder == nil)
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    return [[binder doAction:@"textFieldShouldBeginEditing" withParam:param] boolValue];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(binder == nil)
        return;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    [binder doAction:@"textFieldDidBeginEditing" withParam:param];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(binder == nil)
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    return [[binder doAction:@"textFieldShouldEndEditing" withParam:param] boolValue];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(binder == nil)
        return;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    [binder doAction:@"textFieldDidEndEditing" withParam:param];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(binder == nil)
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    param[@"shouldChangeCharactersInRange"] = NSStringFromRange(range);
    param[@"replacementString"] = string;
    return [[binder doAction:@"textField:shouldChangeCharactersInRange:replacementString" withParam:param] boolValue];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(binder == nil)
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    return [[binder doAction:@"textFieldShouldClear" withParam:param] boolValue];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(binder == nil)
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    return [[binder doAction:@"textFieldShouldReturn" withParam:param] boolValue];
}

///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////
// UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(binder == nil)
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"tableView"] = tableView;
    param[@"section"] = [NSNumber numberWithInteger:section];
    return [[binder doAction:@"tableView:numberOfRowsInSection" withParam:param] integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(binder == nil)
        return nil;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"tableView"] = tableView;
    param[@"indexPath"] = indexPath;
    return [binder doAction:@"tableView:cellForRowAtIndexPath" withParam:param];
}


@end
