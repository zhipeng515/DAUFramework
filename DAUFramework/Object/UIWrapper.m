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
    Binder * dataBinder = [Binder binderWithObject:data withScope:data.scope];
    dataBinder[key] = self;
    if(action)
        [self addAction:action withTrigger:@"dataSourceChanged"];
    
    // 因为数据和UI是一对多的关系，所以需要记录UI绑到那个数据上面了，利用作用域销毁Binder的时候
    // 在Binder的dealloc里面释放Data记录的UI
    Binder * uiBinder = [Binder binderWithObject:self withScope:self.scope];
    uiBinder[key] = data;
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
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"value"] = value;
    [binder doAction:@"dataSourceChanged" withParam:param];
}

///////////////////////////////////////////////////////////////////////////////////////////
// UIButton
- (void)onTap:(nonnull id)sender
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
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
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    NSArray * resultArray = [binder doAction:@"textFieldShouldBeginEditing" withParam:param];
    return [[resultArray valueForKeyPath:@"@min.integerValue"] integerValue];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    [binder doAction:@"textFieldDidBeginEditing" withParam:param];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    NSArray * resultArray = [binder doAction:@"textFieldShouldEndEditing" withParam:param];
    return [[resultArray valueForKeyPath:@"@min.integerValue"] integerValue];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    [binder doAction:@"textFieldDidEndEditing" withParam:param];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    param[@"shouldChangeCharactersInRange"] = NSStringFromRange(range);
    param[@"replacementString"] = string;
    NSArray * resultArray = [binder doAction:@"textField:shouldChangeCharactersInRange:replacementString" withParam:param];
    return [[resultArray valueForKeyPath:@"@min.integerValue"] integerValue];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    NSArray * resultArray = [binder doAction:@"textFieldShouldClear" withParam:param];
    return [[resultArray valueForKeyPath:@"@min.integerValue"] integerValue];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    NSArray * resultArray = [binder doAction:@"textFieldShouldReturn" withParam:param];
    return [[resultArray valueForKeyPath:@"@min.integerValue"] integerValue];
}

///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////
// UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return 0;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"tableView"] = tableView;
    param[@"section"] = [NSNumber numberWithInteger:section];
    NSArray * resultArray = [binder doAction:@"tableView:numberOfRowsInSection" withParam:param];
    return [[resultArray valueForKeyPath:@"@sum.integerValue"] integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return nil;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"tableView"] = tableView;
    param[@"indexPath"] = indexPath;
    return [binder doAction:@"tableView:cellForRowAtIndexPath" withParam:param][0];
}


@end
