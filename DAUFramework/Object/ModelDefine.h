//
//  ModelDefine.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/26.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelDefine : NSObject

@property(nonatomic,retain)NSString * modelName;
@property(nonatomic,retain)NSString * indexKey;
@property(nonatomic,retain)NSDictionary * propertys;

-(id)init:(NSString*)name withIndexKey:(NSString*)key withPropertys:(NSDictionary*)propertys;
-(bool)checkDefine:(id)model;
-(bool)hasIndexKey;
-(id)buildModel:(id)property;

@end
