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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UICommonAction viewDidLoad:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UICommonAction viewWillAppear:animated withController:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [UICommonAction viewDidAppear:animated withController:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UICommonAction viewWillDisappear:animated withController:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [UICommonAction viewDidDisappear:animated withController:self];
}

- (BOOL)shouldAutorotate
{
    return [UICommonAction shouldAutorotate:self];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [UICommonAction supportedInterfaceOrientations:self];
}

// Returns interface orientation masks.
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [UICommonAction preferredInterfaceOrientationForPresentation:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [UICommonAction didReceiveMemoryWarning:self];
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
