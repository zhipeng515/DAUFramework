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
        assert(className != nil);
        assert(creatorName != nil);

        Class creatorClass = NSClassFromString(className);
        assert(creatorClass != nil);
        [self registerObjectCreator:[[creatorClass alloc] init] withKey:creatorName];
    }
}


-(void)registerObjectCreator:(ObjectCreator*)creator withKey:(id)key
{
    if([self.objectCreators objectForKey:key] != nil)
    {
        assert(false);
        return;
    }
    [ self.objectCreators setObject:creator forKey:key];
}

-(id)createObject:(NSDictionary*)data withKey:(id)key withScope:(NSString*)scope
{
    ObjectCreator * creator = [self.objectCreators objectForKey:key];
    if(creator == nil)
    {
        assert(false);
        return nil;
    }
    
    return [creator create:key withData:data withScope:scope];
}

-(id)getObjectScope:(NSString*)scope withObjects:(Data*)objDict withParentScope:(NSString*)parentScope createPath:(BOOL)create
{
    if(scope == nil || [scope isEqualToString:@""])
        return objDict;
    
    NSString * key;
    NSString * remainKey;
    NSRange range = [scope rangeOfString:@"."];
    if(range.location == NSNotFound) {
        key = scope;
    }
    else {
        key = [scope substringWithRange:NSMakeRange(0, range.location)];
        NSUInteger location = range.location + range.length;
        remainKey = [scope substringWithRange:NSMakeRange(location, scope.length - location)];
    }
    
    Data * scopeDict = objDict[key];
    if(create && scopeDict == nil) {
        scopeDict = [[Data alloc] initWithScope:parentScope];
        [objDict setObject:scopeDict forKey:key];
        if(parentScope == nil) {
            parentScope = key;
        }
        else {
            parentScope = [NSString stringWithFormat:@"%@.%@", parentScope, key];
        }
    }

    return [self getObjectScope:remainKey withObjects:scopeDict withParentScope:parentScope createPath:create];
}

-(void)setObject:(id)model withKey:(id)key withScope:(NSString*)scope
{
    Data * scopeDict = [self getObjectScope:scope withObjects:self.objects withParentScope:nil createPath:YES];
    [scopeDict setObject:model forKey:key];
}

-(void)removeObject:(id)key withScope:(NSString*)scope
{
    Data * scopeDict = [self getObjectScope:scope withObjects:self.objects withParentScope:nil createPath:NO];
    [scopeDict removeObjectForKey:key];
}

-(id)getObject:(id)key withScope:(NSString*)scope
{
    Data * scopeDict = [self getObjectScope:scope withObjects:self.objects withParentScope:nil createPath:NO];
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
    Data * scopeDict = [self getObjectScope:scope withObjects:self.objects withParentScope:nil createPath:NO];
    [scopeDict removeAllObjects];
//    [self.objects removeObjectForKey:scope];
}



@end
