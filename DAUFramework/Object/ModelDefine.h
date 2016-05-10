//
//  ModelDefine.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/26.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelDefine : NSObject

@property(nonatomic,retain,nonnull)NSString * name;             // 对象类名称
@property(nonatomic,retain,nonnull)NSString * type;             // 对象类型
@property(nonatomic,retain,nonnull)NSString * scope;            // 对象作用域
@property(nonatomic,retain,nonnull)NSString * varname;            // 变量名
@property(nonatomic,retain,nonnull)NSDictionary * propertys;    // 对象属性表

-(nonnull id)init:(nonnull NSString*)name withVarname:(nonnull NSString*)varname withType:(nonnull NSString*)type withScope:(nonnull NSString*)scope withPropertys:(nonnull NSDictionary*)propertys;
-(bool)isModelDefine:(nonnull id)model;
-(bool)hasVarname;
-(bool)hasScope;

-(nonnull id)buildModel:(nonnull id)propertys withScope:(nonnull NSString*)scope;

@end
