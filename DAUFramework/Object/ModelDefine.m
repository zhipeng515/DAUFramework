//
//  ModelDefine.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/26.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "ModelDefine.h"
#import "Data.h"
#import "DAUManager.h"

@implementation ModelDefine

-(id)init:(NSString*)name withVarname:(NSString*)varname withType:(NSString*)type withScope:(NSString*)scope withPropertys:(NSDictionary*)propertys
{
    if(self = [super init])
    {
        self.name = name;
        if(type == nil || [type isEqualToString:@""])
            self.type = @"kv";
        else
            self.type = type;
        self.varname = varname;
        self.scope = scope;
        self.propertys = propertys;
    }
    return self;
}

-(bool)hasvarname
{
    return self.varname && ![self.varname isEqualToString:@""];
}

-(bool)hasScope
{
    return self.scope && ![self.scope isEqualToString:@""];
}

-(bool)isModelDefine:(id)model
{
    __block int matchCount = 0;
    if([self.type isEqualToString:@"kv"] && [model isKindOfClass:[NSDictionary class]])
    {
        id varnameValue = model[self.varname];
        if([self hasvarname] && varnameValue == nil)
            return false;
        [model enumerateKeysAndObjectsUsingBlock:^(id key, id modelValue, BOOL *stop) {
            id propertyType = self.propertys[key];
            if(propertyType)
			{
                if([propertyType isKindOfClass:[NSString class]])
                {
                    if([modelValue isKindOfClass:[NSString class]] && [propertyType isEqualToString:@"string"])
                        matchCount++;
                    else if([modelValue isKindOfClass:[NSDictionary class]])
                    {
                        if([propertyType isEqualToString:@"kv"])
                        {
                            matchCount++;
                        }
                        else
                        {
                            NSArray * defines = [[DAUManager shareInstance] getModelDefine:modelValue];
                            matchCount += defines.count;
                        }
                    }
                    else if([modelValue isKindOfClass:[NSNumber class]] && ([propertyType isEqualToString:@"int"] || [propertyType isEqualToString:@"float"] || [propertyType isEqualToString:@"bool"]))
                    {
                        matchCount++;
                    }
                    else if([modelValue isKindOfClass:[NSArray class]])
                    {
                        if([propertyType isEqualToString:@"array"])
                        {
                            matchCount++;
                        }
                        else
                        {
                            NSArray * defines = [[DAUManager shareInstance] getModelDefine:modelValue[0]];
                            matchCount += defines.count;
                        }
                    }
                }
                else if([propertyType isKindOfClass:[NSDictionary class]])
                {
                    NSLog(@"%@", propertyType);
                }
			}
        }];
    }
    else if([self.type isEqualToString:@"array"] && [model isKindOfClass:[NSArray class]])
    {
        
    }
    return matchCount == [self.propertys count];
}

-(id)buildModel:(id)propertys
{
    Data * data = [[Data alloc] init];
    [self.propertys enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        [data setValue:propertys[key] forKey:key];
    }];
    return data;
}

@end
