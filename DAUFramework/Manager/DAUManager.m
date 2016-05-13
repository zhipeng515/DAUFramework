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
#import "DAUViewController.h"
#import "UICommonAction.h"
#import "Action.h"

@implementation DAUManager

+(DAUManager*)shareInstance
{
    static DAUManager * instance = nil;
    if(instance == nil)
        instance = [[DAUManager alloc]init];
    return instance;
}

- (id)init
{
    if(self = [super init])
    {
        self.allDataModel = [[NSMutableDictionary alloc] init];
        self.modelDefineDict = [[NSMutableDictionary alloc] init];
        self.modelDefineKeyDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

+ (NSDictionary*)getDictionaryFromJsonFile:(NSString*)filename
{
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    NSData * jsonData = [NSData dataWithContentsOfFile:path];
    NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    return jsonDict;
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
            NSString * varname = modelDefine[@"varname"];
            NSString * scope = modelDefine[@"scope"];
            NSString * type = modelDefine[@"type"];
            NSDictionary * propertys = modelDefine[@"propertys"];
            
            ModelDefine * model = [[ModelDefine alloc] init:modelName withVarname:varname withType:type withScope:scope withPropertys:propertys];
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
    
//    NSMutableSet * keyMatched = [NSMutableSet setWithCapacity:self.modelDefineDict.count];
//    [data enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
//        NSArray * modelDefines = self.modelDefineKeyDict[key];
//        if(modelDefines)
//           [keyMatched addObjectsFromArray:modelDefines];
//    }];
//    for(ModelDefine * modelDefine in keyMatched)
//    {
//        if([modelDefine isModelDefine:data])
//        {
//            [defines addObject:modelDefine];
//        }
//    }
    
    [self.modelDefineDict enumerateKeysAndObjectsUsingBlock:^(id modelName, id modelDefine, BOOL *stop) {
        if([modelDefine isModelDefine:data])
        {
            [defines addObject:modelDefine];
        }
    }];
    return defines;
}

- (void)parseDataModel:(id)models withScope:(NSString*)scope
{
    NSArray * defines = [self getModelDefine:models];
    for(ModelDefine * define in defines)
    {
        NSString * dataScope = scope;
        NSString * varname = define.name;
        if([define hasScope])
        {
            dataScope = define.scope;
        }
        Data * data = [define buildModel:models withScope:dataScope];
        if([define hasVarname])
        {
            if([define.varname hasPrefix:@"$"])
            {
                varname = [define.varname substringFromIndex:1];
                varname = [data objectForKey:varname];
            }
            else
            {
                varname = define.varname;
            }
        }
        Data * oldData = [[ObjectManager shareInstance] getObject:varname withScope:dataScope];
        if(oldData == nil)
        {
            [[ObjectManager shareInstance] setObject:data withKey:varname withScope:dataScope];
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


+ (NSArray*)parseLayoutModel:(NSArray*)layouts withParent:(id)parent withScope:(NSString*)scope
{
    NSMutableArray * layoutArray = [[NSMutableArray alloc] init];
    for(id layout in layouts)
    {
        NSString * layoutName = layout[@"name"];
		NSString * creatorName = layout[@"creator"];
		NSDictionary * property = layout[@"property"];
        assert(creatorName != nil);
        assert(property != nil);
        
        id layoutValue = [[ObjectManager shareInstance] createObject:property withKey:creatorName withScope:scope];
		[[ObjectManager shareInstance] setObject:layoutValue withKey:layoutName withScope:scope];
        
        [layoutArray addObject:layoutValue];
        
        NSString * uiScope = [NSString stringWithFormat:@"%@.%@", scope, layoutName];
        NSArray * subLayoutArray = [self parseLayoutModel:layout[@"layoutInfo"] withParent:layoutValue withScope:uiScope];
        if([subLayoutArray count] > 0)
            [layoutArray addObject:subLayoutArray];
    };
    return layoutArray;
}

+ (void)createLayoutModel:(nullable NSArray*)layouts withParent:(nullable id)parent
{
    id lastLayout = nil;
    for(id layout in layouts)
    {
        if([layout isKindOfClass:[UIWrapper class]] && [parent isKindOfClass:[UIWrapper class]])
        {
            if([[parent ui] isKindOfClass:[UIViewController class]]) {
                [[parent view] addSubview:[layout ui]];
            }
            else {
                [parent addSubview:[layout ui]];
            }
        }
        if([layout isKindOfClass:[NSArray class]])
           [self createLayoutModel:layout withParent:lastLayout];
        
        lastLayout = layout;
    }
}

-(void)parseBinderModel:(NSDictionary*)binders withScope:(NSString*)scope
{
    
}

+ (void)dataChanged:(Data*)data withKey:(id)key withObject:(id)anObject
{
    Binder *binder = [Binder getBinder:data withScope:data.scope];
    if(![binder isKindOfClass:[DataUIWrapperBinder class]])
        return;
    [binder dataChanged:data withKey:key withValue:anObject];
}

@end
