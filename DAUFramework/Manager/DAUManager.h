//
//  DAUManager.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModelDefine, Data;

@interface DAUManager : NSObject

@property(nonatomic, retain, nonnull)NSMutableDictionary * allDataModel;
@property(nonatomic, retain, nonnull)NSMutableDictionary * modelDefineDict;
@property(nonatomic, retain, nonnull)NSMutableDictionary * modelDefineKeyDict;

+ (nonnull DAUManager*)shareInstance;

- (nonnull id)init;

- (void)loadModelDefine:(nonnull NSDictionary*)modelDefines;
- (nonnull id)getModelDefine:(nonnull id)define;

- (void)parseDataModel:(nonnull NSDictionary*)models withScope:(nonnull NSString*)scope;
- (void)parseLayoutModel:(nonnull NSDictionary*)layouts withScope:(nonnull NSString*)scope;
- (void)parseBinderModel:(nonnull NSDictionary*)binders withScope:(nonnull NSString*)scope;

- (void)dataChanged:(nonnull Data*)data withKey:(nullable id)key withObject:(nonnull id)anObject;

@end
