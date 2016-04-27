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
#import "UI.h"
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
        self.binders = [[NSMutableDictionary alloc] init];
        self.allDataModel = [[NSMutableDictionary alloc] init];
        self.modelDefineDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}


-(void)loadModelDefine:(NSDictionary*)modelDefines
{
    for (NSString * modelKey in modelDefines) {
        id modelDefine = modelDefines[modelKey];
        if([modelDefine isKindOfClass:[NSDictionary class]])
        {
            NSString * indexKey = modelDefine[@"indexKey"];
            NSDictionary * property = modelDefine[@"property"];
            
            ModelDefine * model = [[ModelDefine alloc] init:modelKey withIndexKey:indexKey withPropertys:property];
            [self.modelDefineDict setValue:model forKey:modelKey];
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
    }
}

-(id)getModelDefine:(id)define
{
    if(![define isKindOfClass:[NSDictionary class]])
        return nil;
    
    NSMutableArray * defines = [[NSMutableArray alloc] init];
    for(NSString * modelName in self.modelDefineDict)
    {
        ModelDefine * modelDef = self.modelDefineDict[modelName];
        if([modelDef checkDefine:define])
        {
            [defines addObject:modelDef];
        }
    }
    return defines;
}

-(void)parseDataModel:(NSDictionary*)models withScope:(NSString*)scope
{
    NSArray * defines = [self getModelDefine:models];
    for(ModelDefine * define in defines)
    {
        NSDictionary * data = [define buildModel:models];
        if([define hasIndexKey])
            [[ObjectManager shareInstance] setObject:data withKey:data[define.indexKey] withScope:define.modelName];
        else
            [[ObjectManager shareInstance] setObject:data withKey:define.modelName withScope:scope];
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
    for (NSString * layoutName in layout) {
		NSDictionary * layoutDict = layout[layoutName];
		NSString * creatorName = layoutDict[@"creator"];
		NSDictionary * property = layoutDict[@"property"];
        NSAssert(creatorName != nil, @"creator name is nil");
        NSAssert(property != nil, @"property is nil");

        id layoutValue = [[ObjectManager shareInstance] createObject:property withKey:creatorName];
		[[ObjectManager shareInstance] setObject:layoutValue withKey:layoutName withScope:scope];
	}
}

-(void)parseBinderModel:(NSDictionary*)binders withScope:(NSString*)scope
{
    
}

-(void)bindObject:(id)src withOtherObject:(id)dest withScope:(NSString*)scope
{
    if([src isKindOfClass:[UI class]] && [dest isKindOfClass:[Data class]])
    {
        ViewDataBinder * viewDataBinder = [[ObjectManager shareInstance] createObject:@{@"src":src, @"dest":dest} withKey:@"createViewDataBinder"];
        [[ObjectManager shareInstance] setObject:viewDataBinder withKey:src withScope:scope];
    }
}

-(void)trigger:(id)src withScope:(NSString*)scope
{
    id binder = [[ObjectManager shareInstance] getObject:src withScope:scope];
    if(binder == nil)
    {
        NSAssert(![binder isKindOfClass:[Binder class]], @"object %@ class is not a Binder", src);
        return;
    }
    [binder trigger];
}

@end
