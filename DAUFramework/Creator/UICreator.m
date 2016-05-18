//
//  UICreator.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "UICreator.h"
#import <UIKit/Uikit.h>
#import "UIWrapper.h"
#import "UIColor+HexString.h"
#import "DAUViewController.h"
#import "DAUNavigationController.h"
#import "DAUTabbarController.h"

@implementation UICreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    assert(false);
    return nil;
}



@end

@implementation UIViewCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict withScope:(nonnull NSString*)scope
{
    __autoreleasing UIView * view = [[UIView alloc]init];
    [self parseProperty:dict withObject:view];
    UIWrapper * ui = [[UIWrapper alloc] init:view withScope:scope];
    return ui;
}

-(void)parseProperty:(NSDictionary*)dict withObject:(id)obj;
{
    UIView * view = obj;
    view.frame = CGRectFromString(dict[@"frame"]);
    view.backgroundColor = [UIColor colorWithHexString:dict[@"bgcolor"]];
}

@end


@implementation UIImageViewCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict withScope:(nonnull NSString*)scope
{
    __autoreleasing UIImageView * imageView = [[UIImageView alloc]init];
    [self parseProperty:dict withObject:imageView];
    UIWrapper * ui = [[UIWrapper alloc] init:imageView withScope:scope];
    return ui;
}

@end

@implementation UILabelCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict withScope:(nonnull NSString*)scope
{
    __autoreleasing UILabel * label = [[UILabel alloc] init];
    [self parseProperty:dict withObject:label];
    UIWrapper * ui = [[UIWrapper alloc] init:label withScope:scope];
    return ui;
}



@end

@implementation UITextViewCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict withScope:(nonnull NSString*)scope
{
    __autoreleasing UITextView * textView = [[UITextView alloc] init];
    [self parseProperty:dict withObject:textView];
    UIWrapper * ui = [[UIWrapper alloc] init:textView withScope:scope];
    return ui;
}



@end

@implementation UITextFieldCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict withScope:(nonnull NSString*)scope
{
    __autoreleasing UITextField * textField = [[UITextField alloc] init];
    [self parseProperty:dict withObject:textField];
    UIWrapper * ui = [[UIWrapper alloc] init:textField withScope:scope];
//    textField.delegate = ui;
    return ui;
}



@end

@implementation UIButtonCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict withScope:(nonnull NSString*)scope
{
    __autoreleasing UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [self parseProperty:dict withObject:button];
    UIWrapper * ui = [[UIWrapper alloc] init:button withScope:scope];
    [button addTarget:ui action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
    
    return ui;
}

-(void)parseProperty:(NSDictionary*)dict withObject:(id)obj;
{
    [super parseProperty:dict withObject:obj];
    UIButton * button = obj;
    [button setTitle:dict[@"title"] forState: UIControlStateNormal];
}


@end


@implementation UIViewControllerCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict withScope:(nonnull NSString*)scope
{
	__autoreleasing UIViewController * viewController = [[UIViewController alloc] init];
	UIWrapper * ui = [[UIWrapper alloc] init:viewController withScope:scope];
    viewController.uiWrapper = ui;
    return ui;
}



@end

@implementation DAUViewControllerCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict withScope:(nonnull NSString*)scope
{
    __autoreleasing DAUViewController * viewController = [[DAUViewController alloc] init];
    viewController.controllerName = dict[@"name"];
    UIWrapper * ui = [[UIWrapper alloc] init:viewController withScope:scope];
    viewController.uiWrapper = ui;
    return ui;
}



@end


@implementation UINavigationControllerCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict withScope:(nonnull NSString*)scope
{
	__autoreleasing UINavigationController * naviController = [[UINavigationController alloc] init];
	UIWrapper * ui = [[UIWrapper alloc] init:naviController withScope:scope];
    return ui;
}



@end

@implementation DAUNavigationControllerCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict withScope:(nonnull NSString*)scope
{
    id rootViewController = dict[@"rootViewController"];
    if([rootViewController isKindOfClass:[UIWrapper class]])
        rootViewController = [rootViewController ui];
    __autoreleasing DAUNavigationController * naviController = [[DAUNavigationController alloc] initWithRootViewController:rootViewController];
    naviController.controllerName = dict[@"name"];
    UIWrapper * ui = [[UIWrapper alloc] init:naviController withScope:scope];
    naviController.uiWrapper = ui;
    return ui;
}



@end

@implementation DAUTabbarControllerCreator

-(id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

-(id)create:(NSString*)key withData:(NSDictionary*)dict withScope:(nonnull NSString*)scope
{
    NSArray * viewControllersArray = dict[@"viewControllers"];
    NSMutableArray * viewControllers = [[NSMutableArray alloc] initWithCapacity:[viewControllersArray count]];
    for(id controller in viewControllersArray) {
        if([controller isKindOfClass:[UIWrapper class]])
            [viewControllers addObject:[controller ui]];
        else
            [viewControllers addObject:controller];
    }
    __autoreleasing DAUTabbarController * tabbarController = [[DAUTabbarController alloc] init];
    [tabbarController setViewControllers:viewControllers animated:NO];
    tabbarController.controllerName = dict[@"name"];
    UIWrapper * ui = [[UIWrapper alloc] init:tabbarController withScope:scope];
    tabbarController.uiWrapper = ui;
    return ui;
}



@end
