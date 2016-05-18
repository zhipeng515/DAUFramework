//
//  DAUTabbarController.m
//  DAUFramework
//
//  Created by zhipeng on 16/5/18.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "DAUTabbarController.h"
#import "UIWrapper.h"
#import "ObjectManager.h"
#import "DAUViewController.h"

@interface DAUTabbarController ()

@end

@implementation DAUTabbarController

+ (nullable id)createDAUTabbarController:(nullable NSString*)controllerName withViewControllers:(NSArray*)viewControllers
{
    NSString * controllerScope = [NSString stringWithFormat:@"%@.%d.%@", CONTROLLER_SCOPE, randControllerId(), controllerName];
    UIWrapper * controller = [[ObjectManager shareInstance] createObject:@{@"name":controllerName, @"viewControllers":viewControllers} withKey:@"createDAUTabbarController" withScope:controllerScope];
    [[ObjectManager shareInstance] setObject:controller withKey:controllerName withScope:controllerScope];
        
    return controller;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"DAUTabbarController dealloc %@", self.uiWrapper.scope);
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
