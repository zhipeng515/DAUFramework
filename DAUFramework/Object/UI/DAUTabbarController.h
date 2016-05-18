//
//  DAUTabbarController.h
//  DAUFramework
//
//  Created by zhipeng on 16/5/18.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DAUTabbarController : UITabBarController

+ (nullable id)createDAUTabbarController:(nullable NSString*)controllerName withViewControllers:(nonnull NSArray*)viewControllers;

@end
