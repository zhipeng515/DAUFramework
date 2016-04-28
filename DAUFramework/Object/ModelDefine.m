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

-(id)init:(NSString*)name withIndexKey:(NSString*)key withScope:(NSString*)scope withPropertys:(NSDictionary*)propertys
{
    if([super init])
    {
        self.modelName = name;
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

-(bool)checkDefine:(id)model
{
    int matchCount = 0;
    if([model isKindOfClass:[NSDictionary class]])
    {
        id indexValue = model[self.indexKey];
        if([self hasIndexKey] && indexValue == nil)
            return false;
        for(NSString * key in model)
        {
			NSString * propertyType = self.propertys[key];
            if(propertyType)
			{
                id modelValue = model[key];
                if([modelValue isKindOfClass:[NSString class]] && [propertyType isEqualToString:@"string"])
                    matchCount++;
                else if([modelValue isKindOfClass:[NSDictionary class]] && [propertyType isEqualToString:@"kv"])
                    matchCount++;
                else if([modelValue isKindOfClass:[NSNumber class]] && ([propertyType isEqualToString:@"int"] || [propertyType isEqualToString:@"float"] || [propertyType isEqualToString:@"bool"]))
                    matchCount++;
				else if([modelValue isKindOfClass:[NSArray class]] && [propertyType isEqualToString:@"array"])
                    matchCount++;
			}
        }
    }
    return matchCount == [self.propertys count];
}

-(id)buildModel:(id)property
{
    Data * data = [[Data alloc] init];
    for(NSString * key in self.propertys)
    {
        [data setValue:property[key] forKey:key];
    }
    return data;
}

@end
