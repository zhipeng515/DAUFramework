//
//  DAUCore.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "DataCore.h"

@implementation DataCore

-(id)init
{
    if([super init])
    {
        self.coreDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@end
