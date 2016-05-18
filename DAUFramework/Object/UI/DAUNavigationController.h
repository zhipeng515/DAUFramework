//
//  DAUNavigationController.h
//  DAUFramework
//
//  Created by zhipeng on 16/5/18.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DAUViewController;

@interface DAUNavigationController : UINavigationController

+ (nullable id)createDAUNavigationController:(nullable NSString*)controllerName withRootViewController:(nullable id)viewController;

@end
