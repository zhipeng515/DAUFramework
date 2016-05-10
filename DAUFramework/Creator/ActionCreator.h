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

-(nullable id)create:(nonnull NSString*)key withData:(nonnull NSDictionary*)data withScope:(nonnull NSString *)scope;

@end

