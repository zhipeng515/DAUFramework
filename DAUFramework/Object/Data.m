//
//  DAUCore.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "Data.h"

@implementation Data

-(id)init
{
    if(self = [super init])
    {
        self.subdataDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(id)getData:(NSString*)key
{
    return nil;
}

-(void)add:(NSString*)key withData:(Data*)data
{
    
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    return self;
}

@end
