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

-(void)loadObjectCreator:(NSDictionary*)config;
-(void)registerObjectCreator:(ObjectCreator*)creator withKey:(id)key;

-(id)createObject:(NSDictionary*)data withKey:(id)key;
-(void)setObject:(id)model withKey:(id)key;
-(id)getObject:(id)key;
-(void)removeObject:(id)key;

@end
