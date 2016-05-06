//
//  DataCreator.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "DataCreator.h"
#import "Data.h"

@implementation DataCreator


-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    Data * data = [[Data alloc] init];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        data[key] = obj;
    }];
    return data;
}

@end
