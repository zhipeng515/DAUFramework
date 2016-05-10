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

- (nonnull NSDictionary*)getDictionaryFromJsonFile:(nonnull NSString*)filename;

- (void)loadModelDefine:(nonnull NSDictionary*)modelDefines;
- (nullable id)getModelDefine:(nonnull id)define;

- (void)parseDataModel:(nonnull id)models withScope:(nonnull NSString*)scope;
// 这两个方法不能放到非runloop自动创建的@autoreleasepool之中，因为里面的UI组件是autorlease的，在没有被任何UIKit框架接管之前没有被任何对象持有
// 这样做是为解决内存管理问题，框架本身并不持有任何UIKit对象，保证不会引发循环引用问题，使内存得以正常释放
- (nullable NSArray*)parseLayoutModel:(nonnull NSArray*)layouts withParent:(nullable id)parent withScope:(nonnull NSString*)scope;
- (void)createLayoutModel:(nullable NSArray*)layouts withParent:(nullable id)parent;

- (void)parseBinderModel:(nonnull NSDictionary*)binders withScope:(nonnull NSString*)scope;

- (void)dataChanged:(nonnull Data*)data withKey:(nullable id)key withObject:(nonnull id)anObject;

@end
