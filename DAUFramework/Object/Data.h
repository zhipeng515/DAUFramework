//
//  DAUCore.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject<NSCopying, NSMutableCopying>

@property(nonatomic, retain, nonnull) NSString * key;
@property(nonatomic, retain, nonnull) id data;
@property(nonatomic, retain, nonnull)NSMutableDictionary * subdataDict;

- (nonnull id)copyWithZone:(nullable NSZone *)zone;
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone;


-(nullable id)getData:(nullable NSString*)key;
-(void)add:(nullable NSString*)key withData:(nullable Data*)data;

@end
