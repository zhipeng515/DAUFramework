//
//  ActionCreator.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectCreator.h"

// Create Action Object

@interface ActionCreator : ObjectCreator

-(id)create:(NSString*)key withData:(NSDictionary*)data;

@end

@interface HttpActionCreator : ActionCreator

-(id)create:(NSString*)key withData:(NSDictionary*)data;

@end

@interface UIActionCreator : ActionCreator

-(id)create:(NSString*)key withData:(NSDictionary*)data;

@end

@interface DataActionCreator : ActionCreator

-(id)create:(NSString*)key withData:(NSDictionary*)data;

@end

@interface CustomActionCreator : ActionCreator

-(id)create:(NSString*)key withData:(NSDictionary*)data;

@end
