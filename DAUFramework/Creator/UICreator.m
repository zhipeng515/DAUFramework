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

@implementation DAUUIViewControllerCreator

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
