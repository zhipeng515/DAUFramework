//
//  DAUCore.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject<NSCopying, NSMutableCopying>

@property(nonatomic, retain) NSString * key;
@property(nonatomic, retain) id data;
@property(nonatomic, retain)NSMutableDictionary * subdataDict;

- (id)copyWithZone:(nullable NSZone *)zone;
- (id)mutableCopyWithZone:(nullable NSZone *)zone;


-(id)getData:(NSString*)key;
-(void)add:(NSString*)key withData:(Data*)data;

@end
