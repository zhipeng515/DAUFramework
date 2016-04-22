//
//  ModelManager.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelCreator.h"

@interface ModelManager : NSObject

@property(nonatomic, retain)NSMutableDictionary * modelCreatorDict;
@property(nonatomic, retain)NSMutableDictionary * modelDict;

+(ModelManager*)shareInstance;

-(void)registerModelCreator:(ModelCreator*)creator withKey:(id)key;
-(id)createModel:(NSDictionary*)data withKey:(id)key;

-(void)setModel:(id)model withKey:(id)key;
-(id)getModel:(id)key;

@end
