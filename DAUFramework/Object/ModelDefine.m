//
//  ModelDefine.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/26.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "ModelDefine.h"

@implementation ModelDefine

-(id)init:(NSString*)name withIndexKey:(NSString*)key withPropertys:(NSDictionary*)propertys
{
    if([super init])
    {
        self.modelName = name;
        self.indexKey = key;
        self.propertys = propertys;
    }
    return self;
}

-(bool)hasIndexKey
{
    return self.indexKey && ![self.indexKey isEqualToString:@""];
}

-(bool)checkDefine:(id)model
{
    int matchCount = 0;
    if([model isKindOfClass:[NSDictionary class]])
    {
        id checkIndex = model[_indexKey];
        if([self hasIndexKey] && checkIndex == nil)
            return false;
        for(NSString * key in model)
        {
            if(self.propertys[key])
                matchCount++;
        }
    }
    return matchCount == [self.propertys count];
}

-(id)buildModel:(id)property
{
    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
    for(NSString * key in self.propertys)
    {
        [data setValue:property[key] forKey:key];
    }
    return data;
}

@end
