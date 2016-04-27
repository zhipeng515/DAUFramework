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
@property(nonatomic, retain, nonnull) NSString * scope;
@property(nonatomic, retain, nonnull) id data;

- (nonnull id)copyWithZone:(nullable NSZone *)zone;
- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone;

-(nonnull id)init:(nonnull id)data withKey:(nonnull NSString*)key withScope:(nonnull NSString *)scope;
-(nullable id)getData;
-(void)setData:(nonnull id)data;

@end
