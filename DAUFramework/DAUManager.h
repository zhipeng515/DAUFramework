//
//  DAUManager.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAUManager : NSObject

@property(nonatomic, retain)NSMutableDictionary * binders;

+(DAUManager*)shareInstance;

-(void)bindObject:(id)src withOtherObject:(id)dest;
-(void)trigger:(id)src;

@end
