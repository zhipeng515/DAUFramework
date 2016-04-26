//
//  DataCreator.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectCreator.h"


// Create DataCore Object

@interface DataCreator : ObjectCreator

-(id)create:(NSString*)key withData:(NSDictionary*)dict;

@end
