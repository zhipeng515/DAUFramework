//
//  BindCreator.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectCreator.h"

@interface BinderCreator : ObjectCreator

-(id)create:(NSString*)key withData:(NSDictionary*)data;

@end

@interface ViewDataBinderCreator : BinderCreator

-(id)create:(NSString*)key withData:(NSDictionary*)data;

@end

@interface ViewActionBinderCreator : BinderCreator

-(id)create:(NSString*)key withData:(NSDictionary*)data;

@end

@interface DataActionBinderCreator : BinderCreator

-(id)create:(NSString*)key withData:(NSDictionary*)data;

@end
