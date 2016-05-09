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


-(id)initWithUI:(id)ui
{
    if(self = [super init])
    {
        self.ui = ui;
    }
    return self;
}

- (void)watchData:(nonnull Data*)data withKey:(nonnull NSString*)key withAction:(Action*)action withScope:(NSString*)scope
{
    Binder * binder = [Binder binderWithObject:data withScope:scope];
    binder[key] = self;
    if(action)
        [self addAction:action withTrigger:@"dataSourceChanged" withScope:scope];
}

- (void)addAction:(nonnull Action*)action withTrigger:(NSString*)trigger withScope:(NSString*)scope
{
    Binder * binder = [Binder binderWithObject:self withScope:scope];
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
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    Data * param = [[Data alloc] init];
    param[@"value"] = value;
    [binder doAction:@"dataSourceChanged" withParam:param];
}

///////////////////////////////////////////////////////////////////////////////////////////
// UIButton
- (void)onTap:(nonnull id)sender
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    if(binder == nil)
        return;
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
    if(binder == nil)
        return YES;
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    return [[binder doAction:@"textFieldShouldBeginEditing" withParam:param] boolValue];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    if(binder == nil)
        return;
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    [binder doAction:@"textFieldDidBeginEditing" withParam:param];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    if(binder == nil)
        return YES;
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    return [[binder doAction:@"textFieldShouldEndEditing" withParam:param] boolValue];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    if(binder == nil)
        return;
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    [binder doAction:@"textFieldDidEndEditing" withParam:param];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    if(binder == nil)
        return YES;
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    param[@"shouldChangeCharactersInRange"] = NSStringFromRange(range);
    param[@"replacementString"] = string;
    return [[binder doAction:@"textField:shouldChangeCharactersInRange:replacementString" withParam:param] boolValue];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    if(binder == nil)
        return YES;
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    return [[binder doAction:@"textFieldShouldClear" withParam:param] boolValue];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    if(binder == nil)
        return YES;
    Data * param = [[Data alloc] init];
    param[@"textField"] = textField;
    return [[binder doAction:@"textFieldShouldReturn" withParam:param] boolValue];
}

///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////
// UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    if(binder == nil)
        return YES;
    Data * param = [[Data alloc] init];
    param[@"tableView"] = tableView;
    param[@"section"] = [NSNumber numberWithInteger:section];
    return [[binder doAction:@"tableView:numberOfRowsInSection" withParam:param] integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Binder * binder = [Binder getBinder:self withScope:GLOBAL_SCOPE];
    if(binder == nil)
        return nil;
    Data * param = [[Data alloc] init];
    param[@"tableView"] = tableView;
    param[@"indexPath"] = indexPath;
    return [binder doAction:@"tableView:cellForRowAtIndexPath" withParam:param];
}


@end
