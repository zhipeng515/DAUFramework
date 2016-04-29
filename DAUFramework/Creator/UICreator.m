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
#import "DAUUIViewController.h"

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
    NSAssert(false, @"forbidden");
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

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    UIView * view = [[UIView alloc]init];
    [self parseProperty:dict withObject:view];
    UIWrapper * ui = [[UIWrapper alloc] initWithUI:view];
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

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    
    UIImageView * imageView = [[UIImageView alloc]init];
    UIWrapper * ui = [[UIWrapper alloc] initWithUI:imageView];
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

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    UILabel * label = [[UILabel alloc] init];
    UIWrapper * ui = [[UIWrapper alloc] initWithUI:label];
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

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    UITextView * textView = [[UITextView alloc] init];
    UIWrapper * ui = [[UIWrapper alloc] initWithUI:textView];
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

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    UITextField * textField = [[UITextField alloc] init];
    UIWrapper * ui = [[UIWrapper alloc] initWithUI:textField];
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

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self parseProperty:dict withObject:button];
    UIWrapper * ui = [[UIWrapper alloc] initWithUI:button];
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

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
	UIViewController * viewController = [[UIViewController alloc] init];
	UIWrapper * ui = [[UIWrapper alloc] initWithUI:viewController];
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

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    DAUUIViewController * viewController = [[DAUUIViewController alloc] init];
    UIWrapper * ui = [[UIWrapper alloc] initWithUI:viewController];
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

-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
	UINavigationController * naviController = [[UINavigationController alloc] init];
	UIWrapper * ui = [[UIWrapper alloc] initWithUI:naviController];
    return ui;
}



@end
