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

-(id)getObjectScope:(NSString*)scope withObjectDict:(NSMutableDictionary*)objDict
{
    NSString * key;
    NSString * remainKey;
    NSRange range = [scope rangeOfString:@"."];
    if(range.location == NSNotFound)
    {
        key = scope;
        remainKey = @"";
    }
    else
    {
        key = [scope substringWithRange:NSMakeRange(0, range.location)];
        NSUInteger location = range.location+range.length;
        remainKey = [scope substringWithRange:NSMakeRange(location, scope.length-location)];
    }
    
    NSMutableDictionary * scopeDict = objDict[key];
    if(scopeDict == nil)
    {
        scopeDict = [[NSMutableDictionary alloc] init];
        [objDict setObject:scopeDict forKey:key];
    }
    if(![remainKey isEqualToString:@""])
    {
        return [self getObjectScope:remainKey withObjectDict:scopeDict];
    }
    
    return scopeDict;
}

-(void)setObject:(id)model withKey:(id)key withScope:(NSString*)scope
{
    NSMutableDictionary * scopeDict = [self getObjectScope:scope withObjectDict:self.objectDict];
    NSMutableArray * valueArray = scopeDict[key];
    if(valueArray == nil)
    {
        valueArray = [[NSMutableArray alloc] init];
        [scopeDict setObject:valueArray forKey:key];
    }
    [valueArray addObject:model];
}

-(void)removeObject:(id)key withScope:(NSString*)scope
{
    NSMutableDictionary * scopeDict = [self getObjectScope:scope withObjectDict:self.objectDict];
    [scopeDict removeObjectForKey:key];
}

-(id)getObject:(id)key withScope:(NSString*)scope
{
    NSMutableDictionary * scopeDict = [self getObjectScope:scope withObjectDict:self.objectDict];
    NSArray * valueArray = [scopeDict objectForKey:key];
    NSAssert(valueArray != nil, @"key %@ not found", key);
    return valueArray.count > 1 ? valueArray : valueArray[0];
}

-(void)removeAllObject
{
    [self.objectDict removeAllObjects];
}

-(void)removeAllObject:(NSString*)scope
{
    NSMutableDictionary * scopeDict = [self getObjectScope:scope withObjectDict:self.objectDict];
    [scopeDict removeAllObjects];
//    [self.objectDict removeObjectForKey:scope];
}



@end
