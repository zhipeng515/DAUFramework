//
//  DAUNavigationController.m
//  DAUFramework
//
//  Created by zhipeng on 16/5/18.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "DAUNavigationController.h"
#import "Binder.h"
#import "UIWrapper.h"
#import "ObjectManager.h"
#import "DAUViewController.h"
#import "UICommonAction.h"
#import "Action.h"

@interface DAUNavigationController ()

@end

@implementation DAUNavigationController

+ (nullable id)createDAUNavigationController:(nullable NSString*)controllerName withRootViewController:(id)viewController
{
    NSString * controllerScope = [NSString stringWithFormat:@"%@.%d.%@", CONTROLLER_SCOPE, randControllerId(), controllerName];
    UIWrapper * controller = [[ObjectManager shareInstance] createObject:@{@"name":controllerName, @"rootViewController":viewController} withKey:@"createDAUNavigationController" withScope:controllerScope];
    [[ObjectManager shareInstance] setObject:controller withKey:controllerName withScope:controllerScope];
    
    // 添加默认加载视图方法
    [controller addAction:[Action actionWithSelector:@"defaultNavigationControllerViewWillAppear:" withTarget:[UICommonAction class] withParam:nil withScope:controllerScope] withTrigger:@"viewWillAppear"];
    
    
    return controller;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.uiWrapper.scope];
    param[@"self"] = self;
    param[@"animated"] = [NSNumber numberWithBool:animated];
    [binder doAction:@"viewWillAppear" withParam:param];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.uiWrapper.scope];
    param[@"self"] = self;
    param[@"animated"] = [NSNumber numberWithBool:animated];
    [binder doAction:@"viewDidAppear" withParam:param];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.uiWrapper.scope];
    param[@"self"] = self;
    param[@"animated"] = [NSNumber numberWithBool:animated];
    [binder doAction:@"viewWillDisappear" withParam:param];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.uiWrapper.scope];
    param[@"self"] = self;
    param[@"animated"] = [NSNumber numberWithBool:animated];
    [binder doAction:@"viewDidDisappear" withParam:param];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"DAUNavigationController dealloc %@", self.uiWrapper.scope);
    [[ObjectManager shareInstance] removeAllObject:self.uiWrapper.scope];
    //    NSLog(@"%@", [ObjectManager shareInstance].objects);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
