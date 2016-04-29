//
//  DAUManager.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModelDefine;

@interface DAUManager : NSObject

@property(nonatomic, retain)NSMutableDictionary * binders;
@property(nonatomic, retain)NSMutableDictionary * allDataModel;
@property(nonatomic, retain)NSMutableDictionary * modelDefineDict;
@property(nonatomic, retain)NSMutableDictionary * modelDefineKeyDict;

+(DAUManager*)shareInstance;

-(id)init;

-(void)loadModelDefine:(NSDictionary*)modelDefines;
-(id)getModelDefine:(id)define;

-(void)parseDataModel:(NSDictionary*)models withScope:(NSString*)scope;
-(void)parseLayoutModel:(NSDictionary*)layouts withScope:(NSString*)scope;
-(void)parseBinderModel:(NSDictionary*)binders withScope:(NSString*)scope;

-(void)bindObject:(id)src withOtherObject:(id)dest withScope:(NSString*)scope;
-(void)trigger:(id)src withScope:(NSString*)scope;

@end
