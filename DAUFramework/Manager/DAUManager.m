//
//  DAUManager.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "DAUManager.h"
#import "Binder.h"
#import "ObjectManager.h"
#import "Data.h"
#import "UIWrapper.h"
#import "ModelDefine.h"

@implementation DAUManager

+(DAUManager*)shareInstance
{
    static DAUManager * instance = nil;
    if(instance == nil)
        instance = [[DAUManager alloc]init];
    return instance;
}

-(id)init
{
    if(self = [super init])
    {
        self.allDataModel = [[NSMutableDictionary alloc] init];
        self.modelDefineDict = [[NSMutableDictionary alloc] init];
        self.modelDefineKeyDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (void)bindModel:(ModelDefine*)model withPropertys:(NSDictionary*)propertys
{
    // 保存propertys的key对应的ModelDefine，优化匹配效率
    for(NSString * key in propertys)
    {
        NSMutableArray * keyArray = self.modelDefineKeyDict[key];
        if(keyArray == nil)
        {
            keyArray = [[NSMutableArray alloc] init];
            [self.modelDefineKeyDict setValue:keyArray forKey:key];
        }
        [keyArray addObject:model];
        
        id propertyValue = propertys[@"propertys"];
        if([propertyValue isKindOfClass:[NSDictionary class]])
        {
            [self bindModel:model withPropertys:propertyValue];
        }
    }
}

- (void)loadModelDefine:(NSDictionary*)modelDefines
{
    [modelDefines enumerateKeysAndObjectsUsingBlock:^(id modelName, id modelDefine, BOOL *stop) {
        if([modelDefine isKindOfClass:[NSDictionary class]])
        {
            NSString * indexKey = modelDefine[@"indexKey"];
            NSString * scope = modelDefine[@"scope"];
            NSString * type = modelDefine[@"type"];
            NSDictionary * propertys = modelDefine[@"propertys"];
            
            ModelDefine * model = [[ModelDefine alloc] init:modelName withIndexKey:indexKey withType:type withScope:scope withPropertys:propertys];
            [self.modelDefineDict setValue:model forKey:modelName];

            [self bindModel:model withPropertys:propertys];
        }
//        else if([modelDefine isKindOfClass:[NSString class]])
//        {
//            NSString * modelType = modelDefine;
//            if([modelType isEqualToString:@"array"])
//            {
//                
//            }
//            else if([modelType isEqualToString:@"string"])
//            {
//                
//            }
//            else if[(modelType isEqualToString:@"kv"))]
//            {
//                
//            }
//        }
    }];
}

-(id)getModelDefine:(id)data
{
    if(![data isKindOfClass:[NSDictionary class]])
        return nil;

    NSMutableArray * defines = [[NSMutableArray alloc] init];
    
    NSMutableSet * keyMatched = [NSMutableSet setWithCapacity:self.modelDefineDict.count];
    [data enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSArray * modelDefines = self.modelDefineKeyDict[key];
        if(modelDefines)
           [keyMatched addObjectsFromArray:modelDefines];
    }];
    for(ModelDefine * modelDefine in keyMatched)
    {
        if([modelDefine isModelDefine:data])
        {
            [defines addObject:modelDefine];
        }
    }
    
//    [self.modelDefineDict enumerateKeysAndObjectsUsingBlock:^(id modelName, id modelDefine, BOOL *stop) {
//        if([modelDefine isModelDefine:data])
//        {
//            [defines addObject:modelDefine];
//        }
//    }];
    return defines;
}

-(void)parseDataModel:(NSDictionary*)models withScope:(NSString*)scope
{
    NSArray * defines = [self getModelDefine:models];
    for(ModelDefine * define in defines)
    {
        Data * data = [define buildModel:models];
        NSString * dataScope = scope;
        NSString * key = define.name;
        if([define hasScope])
            dataScope = define.scope;
        if([define hasIndexKey])
            key = [data objectForKey:define.indexKey];
        Data * oldData = [[ObjectManager shareInstance] getObject:key withScope:dataScope];
        if(oldData == nil)
        {
            [[ObjectManager shareInstance] setObject:data withKey:key withScope:dataScope];
        }
        else
        {
            [Data dataCopy:oldData withSource:data];
        }
    }
    
    if([models isKindOfClass:[NSDictionary class]] || [models isKindOfClass:[NSArray class]])
    {
        id object;
        NSEnumerator *enumerator = [models objectEnumerator];
        while ((object = [enumerator nextObject]) != nil) {
            [self parseDataModel:object withScope:scope];
        }
    }
}

-(void)parseLayoutModel:(NSDictionary*)layout withScope:(NSString*)scope
{
    [layout enumerateKeysAndObjectsUsingBlock:^(id layoutName, id layoutDict, BOOL *stop) {
		NSString * creatorName = layoutDict[@"creator"];
		NSDictionary * property = layoutDict[@"property"];
        NSAssert(creatorName != nil, @"creator name is nil");
        NSAssert(property != nil, @"property is nil");
        
        id layoutValue = [[ObjectManager shareInstance] createObject:property withKey:creatorName];
		[[ObjectManager shareInstance] setObject:layoutValue withKey:layoutName withScope:scope];
        
        [self parseLayoutModel:property[@"layoutInfo"] withScope:scope];
    }];
}

-(void)parseBinderModel:(NSDictionary*)binders withScope:(NSString*)scope
{
    
}

- (void)dataChanged:(Data*)data withKey:(id)key withObject:(id)anObject
{
    Binder *binder = [[ObjectManager shareInstance] getObject:data withScope:GLOBAL_SCOPE];
    [binder updateUI:data withKey:key withValue:anObject];
}

@end
