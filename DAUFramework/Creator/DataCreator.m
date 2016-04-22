//
//  DataCreator.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "DataCreator.h"
#import "DataCore.h"

@implementation DataCreator


-(id)create:(NSString*)key withData:(NSDictionary*)dict
{
    DataCore * data = [[DataCore alloc]init];
    return data;
}

@end
