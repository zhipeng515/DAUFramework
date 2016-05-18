//
//  DAUUIViewController.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/29.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <UIKit/UIKit.h>

extern int randControllerId();

@interface DAUViewController : UIViewController

+ (nullable id)createDAUViewController:(nullable NSString*)controllerName;

@end
