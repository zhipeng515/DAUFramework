//
//  UICreator.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelCreator.h"

// Create UI Object

@interface UICreator : ModelCreator

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