//
//  ModelManager.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectCreator.h"

#define GLOBAL_SCOPE @"global"
#define CONTROLLER_SCOPE @"controllers"


@class Data;

@interface ObjectManager : NSObject

@property(nonatomic, retain, nonnull)NSMutableDictionary * objectCreators;
@property(nonatomic, retain, nonnull)Data * objects;


+ (nonnull ObjectManager*)shareInstance;

- (void)loadObjectCreator:(nonnull NSDictionary*)objCreators;
- (void)registerObjectCreator:(nonnull ObjectCreator*)creator withKey:(nonnull id)key;

- (nullable id)createObject:(nonnull NSDictionary*)data withKey:(nonnull id)key withScope:(nonnull NSString*)scope;
- (void)setObject:(nonnull id)model withKey:(nonnull id)key withScope:(nonnull NSString*)scope;
- (nullable id)getObject:(nullable id)key withScope:(nonnull NSString*)scope;
- (void)removeObject:(nonnull id)key withScope:(nonnull NSString*)scope;
- (void)removeAllObject;
- (void)removeAllObject:(nonnull NSString*)scope;

@end
