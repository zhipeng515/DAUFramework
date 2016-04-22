//
//  ModelManager.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "ModelManager.h"

@implementation ModelManager

+(ModelManager*)shareInstance
{
    static ModelManager * instance = nil;
    if(instance == nil)
        instance = [[ModelManager alloc] init];
    return instance;
}

-(id)init
{
    if(self = [super init])
    {
        self.modelCreatorDict = [[NSMutableDictionary alloc] init];
        self.modelDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)registerModelCreator:(ModelCreator*)creator withKey:(id)key
{
    if([self.modelCreatorDict objectForKey:key] != nil)
    {
        NSAssert(false, @"key %@ already exists", key);
        return;
    }
    [ self.modelCreatorDict setObject:creator forKey:key];
}

-(id)createModel:(NSDictionary*)data withKey:(id)key
{
    ModelCreator * creator = [self.modelCreatorDict objectForKey:key];
    if(creator == nil)
    {
        NSAssert(true, @"key %@ not found", key);
        return nil;
    }
    
    return [creator create:key withData:data];
}

-(void)setModel:(id)model withKey:(id)key
{
    [self.modelDict setObject:model forKey:key];
}

-(id)getModel:(id)key
{
    id model = [self.modelDict objectForKey:key];
    NSAssert(model != nil, @"key %@ not found", key);
    return model;
}


@end
