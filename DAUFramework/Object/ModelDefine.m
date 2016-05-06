//
//  ModelDefine.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/26.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "ModelDefine.h"
#import "Data.h"

@implementation ModelDefine

-(id)init:(NSString*)name withIndexKey:(NSString*)key withType:(NSString*)type withScope:(NSString*)scope withPropertys:(NSDictionary*)propertys
{
    if(self = [super init])
    {
        self.name = name;
        if(type == nil || [type isEqualToString:@""])
            self.type = @"kv";
        else
            self.type = type;
        self.indexKey = key;
        self.scope = scope;
        self.propertys = propertys;
    }
    return self;
}

-(bool)hasIndexKey
{
    return self.indexKey && ![self.indexKey isEqualToString:@""];
}

-(bool)hasScope
{
    return self.scope && ![self.scope isEqualToString:@""];
}

-(bool)isModelDefine:(id)model
{
    __block int matchCount = 0;
    if( [self.type isEqualToString:@"kv"] && [model isKindOfClass:[NSDictionary class]])
    {
        id indexValue = model[self.indexKey];
        if([self hasIndexKey] && indexValue == nil)
            return false;
        [model enumerateKeysAndObjectsUsingBlock:^(id key, id modelValue, BOOL *stop) {
            id propertyType = self.propertys[key];
            if(propertyType)
			{
                if([propertyType isKindOfClass:[NSString class]])
                {
                    if([modelValue isKindOfClass:[NSString class]] && [propertyType isEqualToString:@"string"])
                        matchCount++;
                    else if([modelValue isKindOfClass:[NSDictionary class]] && [propertyType isEqualToString:@"kv"])
                        matchCount++;
                    else if([modelValue isKindOfClass:[NSNumber class]] && ([propertyType isEqualToString:@"int"] || [propertyType isEqualToString:@"float"] || [propertyType isEqualToString:@"bool"]))
                        matchCount++;
                    else if([modelValue isKindOfClass:[NSArray class]] && [propertyType isEqualToString:@"array"])
                        matchCount++;
                }
                else if([propertyType isKindOfClass:[NSDictionary class]])
                {
                    NSLog(@"%@", propertyType);
                }
			}
        }];
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
