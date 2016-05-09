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
#import "Action.h"
#import "UIWrapper.h"

@interface DAUViewController ()

@end

@implementation DAUViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.controllerName];
    [binder doAction:@"viewDidLoad" withParam:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.controllerName];
    [binder doAction:@"viewWillAppear" withParam:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.controllerName];
    [binder doAction:@"viewDidAppear" withParam:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.controllerName];
    [binder doAction:@"viewWillDisappear" withParam:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.controllerName];
    [binder doAction:@"viewDidDisappear" withParam:nil];
}

// Called just before the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.controllerName];
    [binder doAction:@"viewWillLayoutSubviews" withParam:nil];
}

// Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    Binder * binder = [Binder getBinder:self.uiWrapper withScope:self.controllerName];
    [binder doAction:@"viewDidLayoutSubviews" withParam:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[ObjectManager shareInstance] removeAllObject:self.controllerName];
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
