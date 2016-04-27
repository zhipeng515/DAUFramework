//
//  DAUCore.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "Data.h"
#import "ObjectManager.h"

@implementation Data

-(id)init:(id)data withKey:(NSString*)key withScope:(NSString *)scope
{
    if(self = [super init])
    {
        self.key = key;
        self.scope = scope;
        [self setData:data];
    }
    return self;
}

-(nullable id)getData
{
    return [[ObjectManager shareInstance] getObject:self.key withScope:self.scope];
}

-(void)setData:(id)data
{
    [[ObjectManager shareInstance] setObject:data withKey:self.key withScope:self.scope];
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
