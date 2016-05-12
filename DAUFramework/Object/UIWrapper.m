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
#import "UICommonAction.h"
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

- (BOOL)hasWatched:(nonnull Data*)data withKey:(nonnull NSString*)key
{
    Binder * dataBinder = [Binder getBinder:data withScope:data.scope];
    return [dataBinder hasBinded:self forKey:key];
}

- (void)watchData:(nonnull Data*)data withKey:(nonnull NSString*)key
{
    UICommonAction * target = [UICommonAction shareInstance];
    NSString * selector = [target objectToUpdateSelector:self.ui];
    assert(selector != nil);
    
#ifdef DEBUG
    assert(![self hasWatched:data withKey:key]);
#endif
    [self watchData:data withAction:[Action actionWithSelector:selector withTarget:target withParam:nil withScope:self.scope] withKey:key, nil];
}

- (void)watchData:(nonnull Data*)data withAction:(Action*)action withKey:(nonnull NSString*)key,...NS_REQUIRES_NIL_TERMINATION
{
    Binder * dataBinder = [Binder binderWithObject:data withScope:data.scope];

    NSMutableArray *keyArray = [[NSMutableArray alloc] init];
    if(key)
    {
        [keyArray addObject:key];
        
        va_list params;
        va_start(params, key);
        NSString *arg;
        while((arg = va_arg(params,NSString *)))
        {
            if(arg)
            {
                [keyArray addObject:arg];
            }
        }
        va_end(params);
    }
    
    for (NSString *str in keyArray)
    {
        // 解绑之前的关注
        [self unwatchData:data withKey:str];
        
        dataBinder[str] = self;
        if(action)
        {
            NSString * actionKey = [NSString stringWithFormat:@"dataSourceChanged.%@", str];
            [self addAction:action withTrigger:actionKey];

            // 关注变量之后进行初始化赋值
            [self dataChanged:data[str] withKey:str];
        }
    }

    // 因为数据和UI是一对多的关系，所以需要记录UI绑到那个数据上面了，利用作用域销毁Binder的时候
    // 在Binder的dealloc里面释放Data记录的UI
    Binder * uiBinder = [Binder binderWithObject:self withScope:self.scope];
    uiBinder[self] = data;
}

- (void)unwatchData:(nonnull Data*)data withKey:(nonnull NSString*)key
{
    Binder * dataBinder = [Binder binderWithObject:data withScope:data.scope];
    [dataBinder removeObjectForKey:key];

    NSString * actionKey = [NSString stringWithFormat:@"dataSourceChanged.%@", key];
    [self removeAction:actionKey];
}

- (void)addAction:(nonnull Action*)action withTrigger:(NSString*)trigger
{
    Binder * binder = [Binder binderWithObject:self withScope:self.scope];
    binder[trigger] = action;
}

- (void)removeAction:(nonnull NSString*)trigger
{
    Binder * binder = [Binder binderWithObject:self withScope:self.scope];
    [binder removeObjectForKey:trigger];
}

- (void)removeAllActions
{
    Binder * binder = [Binder binderWithObject:self withScope:self.scope];
    [binder removeAllObjects];
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
    [super encodeWithCoder:aCoder];
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


- (void)dataChanged:(nonnull id)value withKey:(NSString*)key
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"key"] = key;
    param[@"value"] = value;
    param[@"self"] = self;
    NSString * actionKey = [NSString stringWithFormat:@"dataSourceChanged.%@", key];
    [binder doAction:actionKey withParam:param];
}

///////////////////////////////////////////////////////////////////////////////////////////
// UIButton
- (void)onTap:(nonnull id)sender
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"self"] = sender;
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
    if([resultArray count] > 0)
        return [[resultArray valueForKeyPath:@"@min.integerValue"] integerValue] > 0;
    
    return YES;
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
    if([resultArray count] > 0)
        return [[resultArray valueForKeyPath:@"@min.integerValue"] integerValue] > 0;
    return YES;
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
    param[@"data"] = binder[self];
    param[@"textField"] = textField;
    param[@"shouldChangeCharactersInRange"] = NSStringFromRange(range);
    param[@"replacementString"] = string;
    NSArray * resultArray = [binder doAction:@"textField:shouldChangeCharactersInRange:replacementString" withParam:param];
    if([resultArray count] > 0)
        return [[resultArray valueForKeyPath:@"@min.integerValue"] integerValue] > 0;
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    NSArray * resultArray = [binder doAction:@"textFieldShouldClear" withParam:param];
    if([resultArray count] > 0)
        return [[resultArray valueForKeyPath:@"@min.integerValue"] integerValue] > 0;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    Binder * binder = [Binder getBinder:self withScope:self.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return YES;
    Data * param = [[Data alloc] initWithScope:self.scope];
    param[@"textField"] = textField;
    NSArray * resultArray = [binder doAction:@"textFieldShouldReturn" withParam:param];
    if([resultArray count] > 0)
        return [[resultArray valueForKeyPath:@"@min.integerValue"] integerValue] > 0;
    return YES;
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
