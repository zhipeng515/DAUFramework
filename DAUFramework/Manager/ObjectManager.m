//
//  ModelManager.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "ObjectManager.h"
#import "Data.h"

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
        self.objectCreators = [[NSMutableDictionary alloc] init];
        self.objects = [[NSMutableDictionary alloc] init];
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
    if([self.objectCreators objectForKey:key] != nil)
    {
        NSAssert(false, @"key %@ already exists", key);
        return;
    }
    [ self.objectCreators setObject:creator forKey:key];
}

-(id)createObject:(NSDictionary*)data withKey:(id)key
{
    ObjectCreator * creator = [self.objectCreators objectForKey:key];
    if(creator == nil)
    {
        NSAssert(true, @"key %@ not found", key);
        return nil;
    }
    
    return [creator create:key withData:data];
}

-(id)getObjectScope:(NSString*)scope withobjects:(NSMutableDictionary*)objDict
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
        NSUInteger location = range.location + range.length;
        remainKey = [scope substringWithRange:NSMakeRange(location, scope.length - location)];
    }
    
    NSMutableDictionary * scopeDict = objDict[key];
    if(scopeDict == nil)
    {
        scopeDict = [[NSMutableDictionary alloc] init];
        [objDict setObject:scopeDict forKey:key];
    }
    if(![remainKey isEqualToString:@""])
    {
        return [self getObjectScope:remainKey withobjects:scopeDict];
    }
    
    return scopeDict;
}

-(void)setObject:(id)model withKey:(id)key withScope:(NSString*)scope
{
    NSMutableDictionary * scopeDict = [self getObjectScope:scope withobjects:self.objects];
    [scopeDict setObject:model forKey:key];
    
//    NSMutableArray * valueArray = scopeDict[key];
//    if(valueArray == nil)
//    {
//        valueArray = [[NSMutableArray alloc] init];
//        [scopeDict setObject:valueArray forKey:key];
//    }
//    [valueArray addObject:model];
}

-(void)removeObject:(id)key withScope:(NSString*)scope
{
    NSMutableDictionary * scopeDict = [self getObjectScope:scope withobjects:self.objects];
    [scopeDict removeObjectForKey:key];
}

-(id)getObject:(id)key withScope:(NSString*)scope
{
    NSMutableDictionary * scopeDict = [self getObjectScope:scope withobjects:self.objects];
    return [scopeDict objectForKey:key];

//    NSArray * valueArray = [scopeDict objectForKey:key];
//    NSAssert(valueArray != nil, @"key %@ not found", key);
//    return valueArray.count > 1 ? valueArray : valueArray[0];
}

-(void)removeAllObject
{
    [self.objects removeAllObjects];
}

-(void)removeAllObject:(NSString*)scope
{
    NSMutableDictionary * scopeDict = [self getObjectScope:scope withobjects:self.objects];
    [scopeDict removeAllObjects];
//    [self.objects removeObjectForKey:scope];
}



@end
