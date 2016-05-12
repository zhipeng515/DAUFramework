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
        self.objects = [[Data alloc] initWithScope:nil];
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

-(id)createObject:(NSDictionary*)data withKey:(id)key withScope:(NSString*)scope
{
    ObjectCreator * creator = [self.objectCreators objectForKey:key];
    if(creator == nil)
    {
        NSAssert(true, @"key %@ not found", key);
        return nil;
    }
    
    return [creator create:key withData:data withScope:scope];
}

-(id)getObjectScope:(NSString*)scope withobjects:(Data*)objDict createPath:(BOOL)create
{
    if(scope == nil)
        return nil;
    
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
    
    Data * scopeDict = objDict[key];
    if(create && scopeDict == nil)
    {
        NSString * scopeKey = key;
        if(objDict.scope)
            scopeKey = [NSString stringWithFormat:@"%@.%@", objDict.scope, key];
        scopeDict = [[Data alloc] initWithScope:scopeKey];
        [objDict setObject:scopeDict forKey:key];
    }
    if(![remainKey isEqualToString:@""])
    {
        return [self getObjectScope:remainKey withobjects:scopeDict createPath:create];
    }
    
    return scopeDict;
}

-(void)setObject:(id)model withKey:(id)key withScope:(NSString*)scope
{
    Data * scopeDict = [self getObjectScope:scope withobjects:self.objects createPath:YES];
    [scopeDict setObject:model forKey:key];
}

-(void)removeObject:(id)key withScope:(NSString*)scope
{
    Data * scopeDict = [self getObjectScope:scope withobjects:self.objects createPath:NO];
    [scopeDict removeObjectForKey:key];
}

-(id)getObject:(id)key withScope:(NSString*)scope
{
    Data * scopeDict = [self getObjectScope:scope withobjects:self.objects createPath:NO];
    if(key == nil)
        return scopeDict;
    return [scopeDict objectForKey:key];
}

-(void)removeAllObject
{
    [self.objects removeAllObjects];
}

-(void)removeAllObject:(NSString*)scope
{
    Data * scopeDict = [self getObjectScope:scope withobjects:self.objects createPath:NO];
    [scopeDict removeAllObjects];
//    [self.objects removeObjectForKey:scope];
}



@end
