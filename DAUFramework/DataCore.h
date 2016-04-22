//
//  DAUCore.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataCore : NSObject

@property(nonatomic, retain) NSString * key;
@property(nonatomic, retain) id data;
@property(nonatomic, retain)NSMutableDictionary * coreDict;

-(id)create:(NSString*)key withData:(NSDictionary*)data;

@end
