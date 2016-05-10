//
//  ModelCreator.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectCreator : NSObject

-(id)create:(NSString*)key withData:(NSDictionary*)data withScope:(nonnull NSString*)scope;

@end
