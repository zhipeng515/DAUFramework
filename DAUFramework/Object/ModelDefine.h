//
//  ModelDefine.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/26.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelDefine : NSObject

@property(nonatomic,retain)NSString * name;             // 对象类名称
@property(nonatomic,retain)NSString * type;             // 对象类型
@property(nonatomic,retain)NSString * scope;            // 对象作用域
@property(nonatomic,retain)NSString * varname;            // 变量名
@property(nonatomic,retain)NSDictionary * propertys;    // 对象属性表

-(id)init:(NSString*)name withVarname:(NSString*)varname withType:(NSString*)type withScope:(NSString*)scope withPropertys:(NSDictionary*)propertys;
-(bool)isModelDefine:(id)model;
-(bool)hasVarname;
-(bool)hasScope;

-(id)buildModel:(id)propertys;

@end
