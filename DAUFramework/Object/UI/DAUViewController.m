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
    
    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.uiWrapper.scope];
    param[@"self"] = self;
    [binder doAction:@"loadView" withParam:param];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.uiWrapper.scope];
    param[@"self"] = self;
    [binder doAction:@"viewDidLoad" withParam:param];
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

// Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.uiWrapper.scope];
    param[@"self"] = self;
    [binder doAction:@"viewWillLayoutSubviews" withParam:param];
}

// Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.uiWrapper.scope];
    if(![binder isKindOfClass:[UIWrapperActionBinder class]])
        return;
    Data * param = [[Data alloc] initWithScope:self.uiWrapper.scope];
    param[@"self"] = self;
    [binder doAction:@"viewDidLayoutSubviews" withParam:param];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
