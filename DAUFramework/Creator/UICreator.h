//
//  UICreator.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectCreator.h"

// Create UI Object

@interface UICreator : ObjectCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;
-(void)parseProperty:(NSDictionary*)dict withObject:(id)obj;

@end

@interface UIViewCreator : UICreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;
-(void)parseProperty:(NSDictionary*)dict withObject:(id)obj;

@end

@interface UIImageViewCreator : UIViewCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;
-(void)parseProperty:(NSDictionary*)dict withObject:(id)obj;

@end

@interface UIButtonCreator : UIViewCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;
-(void)parseProperty:(NSDictionary*)dict withObject:(id)obj;

@end

@interface UILabelCreator : UIViewCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;
-(void)parseProperty:(NSDictionary*)dict withObject:(id)obj;

@end


@interface UITextFieldCreator : UIViewCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;
-(void)parseProperty:(NSDictionary*)dict withObject:(id)obj;

@end

@interface UIViewControllerCreator : UICreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;
-(void)parseProperty:(NSDictionary*)dict;

@end

@interface UINavigationControllerCreator : UIViewControllerCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;
-(void)parseProperty:(NSDictionary*)dict;

@end
