//
//  ModelManager.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectCreator.h"

@interface ObjectManager : NSObject

@property(nonatomic, retain)NSMutableDictionary * objectCreatorDict;
@property(nonatomic, retain)NSMutableDictionary * objectDict;


+(ObjectManager*)shareInstance;

-(void)loadObjectCreator:(NSDictionary*)objCreators;
-(void)registerObjectCreator:(ObjectCreator*)creator withKey:(id)key;

-(id)createObject:(NSDictionary*)data withKey:(id)key;
-(BOOL)setObject:(id)model withKey:(id)key withScope:(NSString*)scope;
-(id)getObject:(id)key withScope:(NSString*)scope;
-(void)removeObject:(id)key withScope:(NSString*)scope;
-(void)removeAllObject;
-(void)removeAllObject:(NSString*)scope;

@end
