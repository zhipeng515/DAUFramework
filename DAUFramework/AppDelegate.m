//
//  AppDelegate.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "AppDelegate.h"
#import "DAUViewController.h"
#import "DAUManager.h"
#import "ObjectManager.h"
#import "Action.h"
#import "UIWrapper.h"
#import "GlobalViewModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)removeViewController:(id)param
{
    [self.window setRootViewController:nil];
//    [[ObjectManager shareInstance] removeAllObject];
}

- (void)initGlobalInfo
{
    NSDictionary * jsonDict = [[DAUManager shareInstance] getDictionaryFromJsonFile:@"ObjectCreator"];
    [[ObjectManager shareInstance] loadObjectCreator:jsonDict];
    
    jsonDict = [[DAUManager shareInstance] getDictionaryFromJsonFile:@"ModelDefine"];
    [[DAUManager shareInstance] loadModelDefine:jsonDict];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initGlobalInfo];
    
    NSDictionary * jsonDict = [[DAUManager shareInstance] getDictionaryFromJsonFile:@"RegisterViewLayout"];
    [[DAUManager shareInstance] parseLayoutModel:jsonDict[@"layoutInfo"] withParent:nil withScope:CONTROLLER_SCOPE];
    
    GlobalViewModel * viewModel = [[GlobalViewModel alloc] init];

    UIWrapper * controller = [UIWrapper getUIWrapper:@"registerViewController" withScope:CONTROLLER_SCOPE];
    [controller addAction:[Action actionWithSelector:@selector(viewDidLoad:) withTarget:viewModel withParam:nil] withTrigger:@"viewDidLoad" withScope:CONTROLLER_SCOPE];
    [controller addAction:[Action actionWithSelector:@selector(viewWillAppear:) withTarget:viewModel withParam:nil] withTrigger:@"viewWillAppear" withScope:CONTROLLER_SCOPE];


    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:controller.ui];
    [self.window makeKeyAndVisible];
    
    UIWrapper * button = [UIWrapper getUIWrapper:@"registerButton" withScope:CONTROLLER_SCOPE];
    [button addAction:[Action actionWithSelector:@selector(removeViewController:) withTarget:self withParam:nil] withTrigger:@"onTap" withScope:GLOBAL_SCOPE];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
