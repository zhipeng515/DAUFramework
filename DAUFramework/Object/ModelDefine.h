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
@property(nonatomic,retain)NSString * scope;
@property(nonatomic,retain)NSString * indexKey;
@property(nonatomic,retain)NSDictionary * propertys;

-(id)init:(NSString*)name withIndexKey:(NSString*)key withScope:(NSString*)scope withPropertys:(NSDictionary*)propertys;
-(bool)isModelDefine:(id)model;
-(bool)hasIndexKey;
-(bool)hasScope;

-(id)buildModel:(id)propertys;

@end
