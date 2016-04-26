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

-(void)loadObjectCreator:(NSDictionary*)objCreators
{
    NSArray *creators = objCreators[@"creators"];
    for (NSDictionary * creator in creators) {
        NSString * className = creator[@"className"];
        NSString * creatorName = creator[@"creatorName"];
        NSAssert(className != nil, @"class name is nil");
        NSAssert(creatorName != nil, @"creator name is nil");

        Class creatorClass = NSClassFromString(className);
        NSAssert(creatorClass != nil, @"creator %@ is not implement", className);
        [self registerObjectCreator:[[creatorClass alloc] init] withKey:creatorName];
    }
}


-(void)registerObjectCreator:(ObjectCreator*)creator withKey:(id)key
{
    if([self.objectCreatorDict objectForKey:key] != nil)
    {
        NSAssert(false, @"key %@ already exists", key);
        return;
    }
    [ self.objectCreatorDict setObject:creator forKey:key];
}

-(id)createObject:(NSDictionary*)data withKey:(id)key
{
    ObjectCreator * creator = [self.objectCreatorDict objectForKey:key];
    if(creator == nil)
    {
        NSAssert(true, @"key %@ not found", key);
        return nil;
    }
    
    return [creator create:key withData:data];
}

-(id)getObjectScope:(NSString*)scope
{
    NSMutableDictionary * scopeDict = self.objectDict[scope];
    if(scopeDict == nil)
    {
        scopeDict = [[NSMutableDictionary alloc] init];
        [self.objectDict setObject:scopeDict forKey:scope];
    }
    return scopeDict;
}

-(void)setObject:(id)model withKey:(id)key withScope:(NSString*)scope
{
    NSMutableDictionary * scopeDict = [self getObjectScope:scope];
    [scopeDict setObject:model forKey:key];
}

-(void)removeObject:(id)key withScope:(NSString*)scope
{
    NSMutableDictionary * scopeDict = [self getObjectScope:scope];
    [scopeDict removeObjectForKey:key];
}

-(id)getObject:(id)key withScope:(NSString*)scope
{
    NSMutableDictionary * scopeDict = [self getObjectScope:scope];
    id model = [scopeDict objectForKey:key];
    NSAssert(model != nil, @"key %@ not found", key);
    return model;
}

-(void)removeAllObject
{
    [self.objectDict removeAllObjects];
}

-(void)removeAllObject:(NSString*)scope
{
    NSMutableDictionary * scopeDict = [self getObjectScope:scope];
    [scopeDict removeAllObjects];
    [self.objectDict removeObjectForKey:scope];
}



@end
