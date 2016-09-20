//
//  DAUUIViewController.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/29.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "DAUViewController.h"
#import "Binder.h"
#import "ObjectManager.h"
#import "DAUManager.h"
#import "Action.h"
#import "UIWrapper.h"
#import "UICommonAction.h"

int randControllerId()
{
    return (arc4random() % 1000) + 1000;
}

@interface DAUViewController ()

@end

@implementation DAUViewController

+ (nullable id)createDAUViewController:(nullable NSString*)controllerName
{
    NSString * controllerScope = [NSString stringWithFormat:@"%@.%d.%@", CONTROLLER_SCOPE, randControllerId(), controllerName];
    UIWrapper * controller = [[ObjectManager shareInstance] createObject:@{@"name":controllerName} withKey:@"createDAUViewController" withScope:controllerScope];
    [[ObjectManager shareInstance] setObject:controller withKey:controllerName withScope:controllerScope];
    
    // 添加默认加载视图方法
    [controller addAction:[Action actionWithSelector:@"loadLayoutFromJson:" withTarget:[UICommonAction class] withParam:nil withScope:controllerScope] withTrigger:@"loadView"];
    
    return controller;
}


- (void)loadView
{
    [super loadView];
    
    [UICommonAction loadView:self];
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

// Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    [UICommonAction viewWillLayoutSubviews:self];
}

// Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    [UICommonAction viewDidLayoutSubviews:self];
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
    NSLog(@"DAUViewController dealloc %@", self.uiWrapper.scope);
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
