//
//  ModelManager.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "ObjectManager.h"

@implementation ObjectManager

+(ObjectManager*)shareInstance
{
    static ObjectManager * instance = nil;
    if(instance == nil)
        instance = [[ObjectManager alloc] init];
    return instance;
}

-(id)init
{
    if(self = [super init])
    {
        self.objectCreatorDict = [[NSMutableDictionary alloc] init];
        self.objectDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)loadObjectCreator:(NSDictionary*)config
{
    NSArray *creators = config[@"creators"];
    for (NSDictionary * creator in creators) {
        if (creator) {
            NSString * className = creator[@"className"];
            NSString * creatorName = creator[@"creatorName"];
            NSAssert(className != nil, @"class name is nil");
            NSAssert(creatorName != nil, @"creator name is nil");

            Class creatorClass = NSClassFromString(className);
            NSAssert(creatorClass != nil, @"creator %@ is not implement", className);
            [self registerModelCreator:[[creatorClass alloc] init] withKey:creatorName];
        }
    }
}

-(void)registerModelCreator:(ObjectCreator*)creator withKey:(id)key
{
    if([self.objectCreatorDict objectForKey:key] != nil)
    {
        NSAssert(false, @"key %@ already exists", key);
        return;
    }
    [ self.objectCreatorDict setObject:creator forKey:key];
}

-(id)createModel:(NSDictionary*)data withKey:(id)key
{
    ObjectCreator * creator = [self.objectCreatorDict objectForKey:key];
    if(creator == nil)
    {
        NSAssert(true, @"key %@ not found", key);
        return nil;
    }
    
    return [creator create:key withData:data];
}

-(void)setObject:(id)model withKey:(id)key
{
    [self.objectDict setObject:model forKey:key];
}

-(void)removeObject:(id)key
{
    [self.objectDict removeObjectForKey:key];
}

-(id)getObject:(id)key
{
    id model = [self.objectDict objectForKey:key];
    NSAssert(model != nil, @"key %@ not found", key);
    return model;
}


@end
