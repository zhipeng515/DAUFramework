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

@end

@interface UIViewCreator : UICreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;

@end

@interface UIImageViewCreator : UICreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;

@end

@interface UIButtonCreator : UICreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;

@end

@interface UILabelCreator : UICreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;

@end


@interface UITextFieldCreator : UICreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;

@end

@interface UIViewControllerCreator : UICreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;

@end

@interface UINavigationControllerCreator : UICreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;

@end
