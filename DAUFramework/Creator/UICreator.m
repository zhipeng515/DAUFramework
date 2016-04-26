//
//  UICreator.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "UICreator.h"
#import <UIKit/Uikit.h>
#import "UI.h"

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
    UI * ui = [[UI alloc] initWithUI:view];
    return ui;
}

-(void)parseProperty:(NSDictionary*)dict withObject:(id)obj;
{
    UIView * view = obj;
    view.frame = CGRectMake([dict[@"x"] floatValue], [dict[@"y"] floatValue], [dict[@"w"] floatValue], [dict[@"h"] floatValue]);
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
    UI * ui = [[UI alloc] initWithUI:imageView];
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
    UI * ui = [[UI alloc] initWithUI:label];
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
    UI * ui = [[UI alloc] initWithUI:textField];
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
    UI * ui = [[UI alloc] initWithUI:button];
    return ui;
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
	UI * ui = [[UI alloc] initWithUI:viewController];
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
	UI * ui = [[UI alloc] initWithUI:naviController];
    return ui;
}



@end
